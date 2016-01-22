from customer.models import Customer 
from project.models import Project 
from task.models import Task,TaskEntry

class ProjectHelper():
    def get_project_list(self):
        try:
            projects = Project.objects.all()
        except:
            projects = None
        return projects
    
    def get_project_by_id(self,id):
        try:
            project = Project.objects.get(id=id)
        except:
            project = None
        return project

class CustomerHelper():
    def get_customer_list(self):
        try:
            customers = Customer.objects.all()
        except:
            customers = None
        return customers

class TaskHelper():
    def get_task_by_id(self,request,id):
        try:
            task = Task.objects.filter(user=request.user).get(id=id)
        except:
            task = None
        return task


    def get_user_tasks(self,user):
        try:
            tasks = Task.objects.filter(user=user)
        except:
            tasks = None
        return tasks

    def create_task(self,request,task_name,project_name):
        try:
            project = Project.objects.get(name=project_name)
            task = Task.objects.create(user=request.user,project=project,name=task_name)
        except:
            project, task = None, None
    
        if task:
            return (task, True)
        return (None,False)

    def get_task(self,id):
        try:
            task = Task.objects.get(id=id)
        except: 
            task = None 
        return task

class TaskEntryHelper():
    def create_by_task_id(self,task_id,form):
        try:
            task = Task.objects.get(id=task_id)
        except:
            task = None

        if task:
            try:
                task = TaskEntry.objects.create(task=task,note=form['note'])
            except:
                task = None
            if task:
                return (task,True)
            return (None,False)

    def get_task_entry_by_id(self,entry_id):
        try:
            task_entry = TaskEntry.objects.get(id=entry_id)
        except:
            task_entry = None
        return task_entry

    def get_task_entries_by_user(self,request,task_id):
        helper = TaskHelper()
        task = helper.get_task(task_id)
        if task:
            return (task.taskentry_set.all(),True)
        return (None,False)



class ModelListMixin(TaskEntryHelper,CustomerHelper,ProjectHelper,TaskHelper): pass
   

   

   
