
# Capstone Project II - Files

# Program to help business manage assigned tasks to each member of the team

#===== Importing Libraries ===========

# In this section the lists "user_list" and "password_list" is created.
# The text file "user.txt" is opened for reading as "user_file" to extract
# all the usernames and passwords.
# The usernames will be appended to "user_list" and the passwords appended to
# "password_list"

user_list = []
password_list = []

with open('user.txt' , 'r+') as user_file:
    for line in user_file:
        line = line.rstrip()
        user, password = line.split(", ")
        user_list.append(user)
        password_list.append(password)
    
#===== Admin Login ===========
        
# In this section, a while loop is used to validate the individual's username
# and password.
# If the entered username is equal to "admin" and the password is
# equal to "adm1n",
# an admin_menu will be presented to the admin user/s

while True:
    userName = input("\nPlease enter a valid username: ") 
    userPassword = input("\nPlease enter a valid password: ")
    if (userName == "admin") and (userPassword == "adm1n"):
        admin_menu = input('''\nSelect one of the following options below:
r - Registering a user
a - Adding a task
va - View all tasks
vm - View my task
d - Display statistics
e - Exit
: ''').lower()
        if admin_menu == 'r':
            pass

            # This code block only grants admin users authentication to
            # register new users. 
            # If "r" is selected, admins will be asked to register new users
            # with corresponding passwords - these will be written to
            # 'user.txt'.
                   
            new_username =  input("\nPlease enter a new username: ")
            new_user_password = input("\nPlease enter a new password: ")
            new_password = False
            while new_password == False:
                pass_confirm = input("\nPlease confirm your new password: ")
                if new_user_password == pass_confirm:
                    new_password == True
                    break
                elif new_password == False:
                    print("\nYour passwords do not match. Please try again.")

            with open('user.txt' , 'a') as user_file:
                user_file.write("\n{}, {}".format(new_username, new_user_password))
                    
        elif admin_menu == 'a':
            pass    

            # If admin users select 'a',
            # they will be able to add a task,
            # which will be written to tasks.txt.
                 
            from datetime import datetime
            now = datetime.now()

            taskAssignee = input("\nEnter the username of the task assignee: ")
            taskTitle = input("Enter the title of the task: ")
            taskDescr = input("Enter a description of the task: ")
            taskDue =  input("Enter the due date of the task: ")
            currentDate = now.strftime("%d %b %Y")
            taskComplete = "No"
                 
            with open('tasks.txt' , 'a') as tasks_file:
                tasks_file.write('''\n{}, {}, {}, {}, {}, {}'''.format(taskAssignee, taskTitle, taskDescr,
currentDate, taskDue, taskComplete))
                
        elif admin_menu == 'va':
            pass
        
            # If admin users select 'va', this code block will enable them to
            # view all tasks in 'tasks.txt' in the format shown in the Output 2
            # in L1T19 pdf by:
            # - using a for loop.
            # - reading a line from the file.
            # - splitting each line where there is a comma and white space.
        
            with open('tasks.txt' , 'r+') as tasks_file:
                for line in tasks_file:
                    a = line.split(", ")[1:2]
                    b = line.split(", ")[0:1]
                    c = line.split(", ")[3:4]
                    d = line.split(", ")[4:5]
                    e = line.split(", ")[5::]
                    f = line.split(", ")[2:3]
                    print("Task:                  " + ''.join(a) +"\n"
                          "Assigned to:           " + ''.join(b) +"\n"
                          "Date assigned:         " + ''.join(c) +"\n"
                          "Due date:              " + ''.join(d) +"\n"
                          "Task complete?         " + ''.join(e) +"\n"
                        '''Task description:
        ''' +  ''.join(f) + "\n")
                    
        elif admin_menu == 'vm':
            pass
        
            # If admin user selects 'vm', this block of code will enable them to view
            # their own task in the format shown in the Output 2 in L1T19 pdf by:
            # - using a for loop to read a line from the file;
            # - splitting the line where there is a comma and space; and
            # - by validating whether entered userName is found in line of
            # 'tasks.txt'.

            with open('tasks.txt' , 'r+') as tasks_file:
                for line in tasks_file:
                    line = line.rstrip()
                    if userName in line:
                        a = line.split(", ")[1:2]
                        b = line.split(", ")[0:1]
                        c = line.split(", ")[3:4]
                        d = line.split(", ")[4:5]
                        e = line.split(", ")[5::]
                        f = line.split(", ")[2:3]
                        print("Task:                  " + ''.join(a) +"\n"
                              "Assigned to:           " + ''.join(b) +"\n"
                              "Date assigned:         " + ''.join(c) +"\n"
                              "Due date:              " + ''.join(d) +"\n"
                              "Task complete?         " + ''.join(e) +"\n"
                            '''Task description:
        ''' +  ''.join(f) + "\n")

        elif admin_menu == 'd':
            pass

            # admin users have an additional menu option:
            # display statistics
            # If this option is selected,
            # admin users will be able to display the total
            # number of tasks and users in user-friendly format.
            
            num_of_tasks = 0
            num_of_users = 0

            print("\nAll assigned tasks:")

            with open('tasks.txt' , 'r+') as tasks_file:
                for line in tasks_file:
                    num_of_tasks += 1
                    a = line.split(", ")[1:2]
                    b = line.split(", ")[0:1]
                    c = line.split(", ")[3:4]
                    d = line.split(", ")[4:5]
                    e = line.split(", ")[5::]
                    f = line.split(", ")[2:3]
                    print("Task:                  " + ''.join(a) +"\n"
                          "Assigned to:           " + ''.join(b) +"\n"
                          "Date assigned:         " + ''.join(c) +"\n"
                          "Due date:              " + ''.join(d) +"\n"
                          "Task complete?         " + ''.join(e) +"\n"
                        '''Task description:
        ''' +  ''.join(f) + "\n")
                print(f"\nThe total number of tasks: {num_of_tasks}.")

            print("\nAll users:")
                 
            with open('user.txt' , 'r+') as user_file:
                for line in user_file:
                    num_of_users += 1
                    tot_users = line.split(", ")[0]
                    print(tot_users)                    
                print(f"\nThe total number of users: {num_of_users}.")

                
        elif admin_menu == 'e':
            print('Goodbye!!!')
            exit()
            
    #===== Other users login ===========
            
    # presenting the menu to other users
                
    elif (userName in user_list) and (userPassword in password_list):
        menu = input('''\nSelect one of the following options below:
r - Registering a user
a - Adding a task
va - View all tasks
vm - View my task
e - Exit
: ''').lower()
        if menu == 'r':
            pass

            # If other users select 'r',
            # they will receive an error message.
            # This option is only accessible to admin users.
            
            print('''\nAccess denied. Only admin users have access to register
new users.''')
            break
        
        elif menu == 'a':
            pass    

            # Other logged in users will also be enabled to add a
            # new task, which will be appended/written to 'tasks.txt'.
                 
            from datetime import datetime
            now = datetime.now()

            taskAssignee = input("\nEnter the username of the task assignee: ")
            taskTitle = input("Enter the title of the task: ")
            taskDescr = input("Enter a description of the task: ")
            taskDue =  input("Enter the due date of the task: ")
            currentDate = now.strftime("%d %b %Y")
            taskComplete = "No"
                 
            with open('tasks.txt' , 'a') as tasks_file:
                tasks_file.write('''\n{}, {}, {}, {}, {}, {}'''.format(taskAssignee, taskTitle, taskDescr,
currentDate, taskDue, taskComplete))

        elif menu == 'va':
            pass
        
            # If users select 'va', this code block will enable them to view all
            # tasks in 'tasks.txt' in the format shown in the Output 2
            # in L1T19 pdf by:
            # - using a for loop.
            # - reading a line from the file.
            # - splitting each line where there is a comma and white space.
        
            with open('tasks.txt' , 'r+') as tasks_file:
                for line in tasks_file:
                    a = line.split(", ")[1:2]
                    b = line.split(", ")[0:1]
                    c = line.split(", ")[3:4]
                    d = line.split(", ")[4:5]
                    e = line.split(", ")[5::]
                    f = line.split(", ")[2:3]
                    print("Task:                  " + ''.join(a) +"\n"
                          "Assigned to:           " + ''.join(b) +"\n"
                          "Date assigned:         " + ''.join(c) +"\n"
                          "Due date:              " + ''.join(d) +"\n"
                          "Task complete?         " + ''.join(e) +"\n"
                        '''Task description:
        ''' +  ''.join(f) + "\n")

        elif menu == 'vm':
            pass
        
            # If user selects 'vm', this block of code will enable them to view
            # their own task in the format shown in the Output 2 in L1T19 pdf by:
            # - using a for loop to read a line from the file;
            # - splitting the line where there is a comma and space; and
            # - by validating whether entered userName is found in line of
            # 'tasks.txt'.

            with open('tasks.txt' , 'r+') as tasks_file:
                for line in tasks_file:
                    line = line.rstrip()
                    if userName in line:
                        a = line.split(", ")[1:2]
                        b = line.split(", ")[0:1]
                        c = line.split(", ")[3:4]
                        d = line.split(", ")[4:5]
                        e = line.split(", ")[5::]
                        f = line.split(", ")[2:3]
                        print("Task:                  " + ''.join(a) +"\n"
                              "Assigned to:           " + ''.join(b) +"\n"
                              "Date assigned:         " + ''.join(c) +"\n"
                              "Due date:              " + ''.join(d) +"\n"
                              "Task complete?         " + ''.join(e) +"\n"
                            '''Task description:
        ''' +  ''.join(f) + "\n")

           
        elif menu == 'e':
            print('Goodbye!!!')
            exit()

        else:
            print("You have made a wrong choice, Please Try again.")
            
    # If a user enters an invalid username and/or password,
    # not contained in the user text file,
    # they will repeatedly be prompted for a valid username
    # and password.
    
    else:
        print('''Error! You have entered an invalid username or password.
Please try again.''')
        userName = input("\nPlease enter a valid username: ")
        userPassword = input("\nPlease enter a valid password: ")

        
 
     
            
                

