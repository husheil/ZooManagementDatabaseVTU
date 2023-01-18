from flask import Flask, render_template,request,session,redirect,url_for,flash
from flask_sqlalchemy import SQLAlchemy
import pymysql
pymysql.install_as_MySQLdb()
from flask_login import UserMixin
from werkzeug.security import generate_password_hash, check_password_hash
from flask_login import login_user,logout_user,LoginManager,login_manager
from flask_login import login_required,current_user

flag=False
#DB CONNECTION
local_server=True
app = Flask(__name__)
app.secret_key='husheil'


#USER ACCESS
'''login_manager1=LoginManager(app)
login_manager1.login_view='login'
@login_manager1.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))'''



login_manager_users = LoginManager(app)
login_manager_users.login_view = 'login'
@login_manager_users.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))

login_manager_admins = LoginManager(app)
login_manager_admins.login_view = 'adminlogin'
@login_manager_admins.user_loader
def load_admin(admin_id):
    return Employee.query.get(int(admin_id))


'''login_manager2=LoginManager(app)
login_manager2.login_view='login'
@login_manager2.user_loader
def load_admin(employee_id):
    return Employee.query.get(int(employee_id))'''


    

app.config['SECRET_KEY'] = "random string"
#app.config['SQLALCHEMY_DATABASE_URL']='mysql://username:password@localhost/darabase_table_name'
app.config['SQLALCHEMY_DATABASE_URI']='mysql://root:@localhost/zms'
db = SQLAlchemy(app)

#TABLES
class Test(db.Model):
    id=db.Column(db.Integer,primary_key=True)
    email=db.Column(db.String(100))
    name=db.Column(db.String(100))

class User(UserMixin,db.Model):
    id=db.Column(db.Integer,primary_key=True)
    name=db.Column(db.String(100))
    gender=db.Column(db.String(20))
    username=db.Column(db.String(100))
    email=db.Column(db.String(100),unique=True)
    password=db.Column(db.String(1000))
    phno=db.Column(db.Integer)

class Employee(UserMixin,db.Model):
    id=db.Column(db.Integer,primary_key=True)
    name=db.Column(db.String(100))
    adminemail=db.Column(db.String(100),unique=True)
    adminpassword=db.Column(db.String(1000))
    phno=db.Column(db.String(10))
    salary=db.Column(db.Integer)

class Ticket(UserMixin,db.Model):
    id=db.Column(db.Integer,primary_key=True)
    date=db.Column(db.Date)
    amount=db.Column(db.Integer)
    uid=db.Column(db.Integer,db.ForeignKey('user.id'))

class Animal(UserMixin,db.Model):
    id=db.Column(db.Integer,primary_key=True)
    name=db.Column(db.String(1000))
    type=db.Column(db.String(1000))
    kind=db.Column(db.String(1000))
    gender=db.Column(db.String(20))
    age=db.Column(db.Integer)

class Cares_for(UserMixin,db.Model):
    uid=db.Column(db.Integer,db.ForeignKey('employee.id'),primary_key=True)
    aid=db.Column(db.Integer,db.ForeignKey('animal.id'),primary_key=True)


def check_password(plaintext_password, stored_password):
    return plaintext_password == stored_password

# here we will pass endpoints and run the function 
@app.route('/')
def index():
    return render_template('index.html')
@app.route('/cares_for')
#@login_required
def cares_for():
    list1=Cares_for.query.order_by(Cares_for.uid)
    return render_template('cares_for.html',list1=list1)
@app.route('/altercf',methods=['POST','GET'])
def altercf():
    list1=Animal.query.order_by(Animal.id)
    list2=Employee.query.order_by(Employee.id)
    if request.method == "POST":
            uid=request.form.get('uid')
            aid=request.form.get('aid') 
            new_item=db.engine.execute(f"INSERT INTO `cares_for`(`uid`,`aid`) VALUES('{uid}','{aid}');")
    return render_template('altercf.html',list1=list1,list2=list2)
@app.route('/viewtickets')
def viewticket():
    ticketlist=Ticket.query.order_by(Ticket.date)
    return render_template('viewtickets.html',ticketlist=ticketlist)
@app.route('/animals')
#@login_required
def animal():
    animallist=Animal.query.order_by(Animal.id)
    return render_template('animals.html',animallist=animallist)
@app.route('/employee')
def employee():
    userlist=Employee.query.order_by(Employee.id)
    return render_template('employee.html',userlist=userlist)   
@app.route('/gallery')
def gallery():
    return render_template('gallery.html') 
@app.route('/booking',methods=['POST','GET'])
#@login_required
def booking():
    #flash(flag,"danger")
    if flag:
        #flash("Login as User to Book Tickets","info")
        #return render_template('login.html')
        if request.method=="POST":
            email=request.form.get('email')
            name=request.form.get('name')
            gender=request.form.get('gender')
            date=request.form.get('date')
            number=request.form.get('number')
            user=User.query.filter_by(email=email).first()
            if user:
                uid=user.id
                db.engine.execute(f"UPDATE user SET name='{name}',gender='{gender}',phno='{number}' WHERE email='{email}';")
                db.engine.execute(f"INSERT INTO `ticket`(`date`,`uid`) VALUES('{date}','{uid}');")
                t = Ticket.query.filter_by(uid=uid).order_by(Ticket.id.desc()).first()
                return render_template('tickets.html',tid=t.id,d=t.date,uid=t.uid,name=user.name)
    else:
        flash("Please Log In","warning")
        return render_template('login.html')
    return render_template('booking.html') #,username=current_user.username
@app.route('/tickets',methods=['GET'])
def tickets():
    u1=current_user.id
    t1=db.engine.execute(f"SELECT date,tid FROM ticket WHERE uid='{u1}';")
    return render_template('tickets.html', name=current_user.name,u1=current_user.id,tid=t1.id,d=t1.date)
 


@app.route('/login',methods=['POST','GET'])
def login():
    global flag 
    if flag:
        flash("Already Logged In","info")
        return render_template("index.html")
    if request.method == "POST":
        email=request.form.get('email')
        password=request.form.get('password')
        user = User.query.filter_by(email=email).first()
        if user and check_password_hash(user.password,password):
            flag = True
            login_user(user)
            flash("Login Success","success")
            return redirect(url_for('index'))
        else:
            flash("INVALID CREDENTIALS","danger")
            return render_template('login.html')

    return render_template('login.html')
@app.route('/adminlogin',methods=['POST','GET'])
def adminlogin():
    if request.method == "POST":
        adminemail=request.form.get('adminemail')
        adminpassword=request.form.get('adminpassword')
        #apassword=generate_password_hash(adminpassword)
        user = Employee.query.filter_by(adminemail=adminemail).first()
        if user and check_password(user.adminpassword,adminpassword):#check_password_hash(admin.adminpassword,adminpassword):
            login_user(user)
            return redirect(url_for('admin1'))
        else:
            flash("INVALID CREDENTIALS","danger")
            return render_template('adminlogin.html')

    return render_template('adminlogin.html')  
@login_required
@app.route('/admin1')
def admin1():
    return render_template('admin1.html')
@app.route('/logout')
def logout():
    global flag
    flag= False
    logout_user()
    flash("Log out Successful","dark")
    return render_template('login.html')
    return redirect(url_for('login'))
@app.route('/register',methods=['POST','GET'])
def register():
    if request.method == "POST":
        username=request.form.get('username')
        email=request.form.get('email')
        password=request.form.get('password')
        user=User.query.filter_by(email=email).first()
        if user:
            flash("Email already exists","warning")
            return render_template('/login.html')

        epassword=generate_password_hash(password)
        #TO SAVE DATA IN DB
        new_user=db.engine.execute(f"INSERT INTO `user`(`username`,`email`,`password`) VALUES('{username}','{email}','{epassword}');")
        flash("Successfully Registered. Please Log in","dark")
        return render_template('/login.html')
    return render_template('register.html')

@login_required
@app.route('/eregister',methods=['POST','GET'])
def eregister():
    if request.method == "POST":
        name=request.form.get('name')
        email=request.form.get('adminemail')
        password=request.form.get('adminpassword')
        phno=request.form.get('phno')
        user=Employee.query.filter_by(adminemail=email).first()
        if user:
            flash("Email already exists","warning")
            return render_template('/adminlogin.html')
        #TO SAVE DATA IN DB
        new_user=db.engine.execute(f"INSERT INTO `employee`(`name`,`adminemail`,`adminpassword`,`phno`) VALUES('{name}','{email}','{password}','{phno}');")
        flash("Successfully Registered. Please Log in","dark")
        return render_template('adminlogin.html')
    return render_template('eregister.html')

@login_required
@app.route('/addanimals',methods=['POST','GET'])
def addanimals():
    if request.method == "POST":
        name=request.form.get('name')
        kind=request.form.get('kind')
        type=request.form.get('type')
        age=request.form.get('age')
        gender=request.form.get('gender')
        animal=Animal.query.filter_by(name=name).first()
        if animal:
            flash("Name already in use","warning")
            return render_template('addanimals.html')
        #TO SAVE DATA IN DB
        new_animal=db.engine.execute(f"INSERT INTO `animal`(`name`,`kind`,`type`,`age`,`gender`) VALUES('{name}','{kind}','{type}','{age}','{gender}');")
    return render_template('addanimals.html')
@app.route('/deleteanimals',methods=['POST','GET'])
def deleteanimals():
    if request.method == "POST":
        name=request.form.get('name')
        animal_to_delete = Animal.query.filter_by(name=name).first()
        if animal_to_delete:
            db.engine.execute(f"DELETE FROM animal WHERE name='{name}'")
        else:
            flash("Animal is not present","warning")
            return render_template("deleteanimals.html")

    animallist=Animal.query.order_by(Animal.id)
    return render_template('deleteanimals.html',animallist=animallist)
@app.route('/test')
def test():
    try:
        Test.query.all()
        return 'My db is Connected'
    except:
        return 'DB not connected'
app.run(debug=True)