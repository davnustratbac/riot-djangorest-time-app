from django.db import models
from project.models import Project 
from django.contrib.auth.models import User 

class Task(models.Model):
	project = models.ForeignKey(Project,blank=True,null=True)
	user    = models.ForeignKey(User,blank=True,null=True)
	name    = models.CharField(max_length=40,blank=True,null=True)

	def __unicode__(self):
		return "task: %s" % (self.name)

	def has_task_entries(self):
		return self.taskentry_set.first() != None

class TaskEntry(models.Model):
	task = models.ForeignKey(Task,blank=True,null=True)
	date_field = models.DateField(auto_now_add=True,blank=True,null=True)
	time_record = models.TimeField(auto_now_add=True,blank=True,null=True)
	duration_in_seconds = models.IntegerField(default=0,blank=True,null=True)
	clock_started = models.BooleanField(default=False)
	note = models.CharField(max_length=400,blank=True,null=True)
	
	def __unicode__(self):
		return str(self.task.name)
