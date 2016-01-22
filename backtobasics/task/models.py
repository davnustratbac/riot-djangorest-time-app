from datetime import datetime,date,time
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

	def task_entry_count(self):
		return len(self.taskentry_set.all()) if self.taskentry_set.first() else 0

	def task_entry_duration_total_in_seconds(self):
		res = 0
		for item in self.taskentry_set.all():
			res += item.get_duration_in_seconds()
		return res

class TaskEntry(models.Model):
	task = models.ForeignKey(Task,blank=True,null=True)
	date_field = models.DateField(auto_now_add=True,blank=True,null=True)
	time_record = models.TimeField(auto_now_add=True,blank=True,null=True)
	duration_in_seconds = models.IntegerField(default=0,blank=True,null=True)
	clock_started = models.BooleanField(default=False)
	note = models.CharField(max_length=400,blank=True,null=True)
	
	def __unicode__(self):
		return str(self.task.name)

	def datetime_last_save(self):
		tf = self.time_record
		hour,min,sec = tf.hour,tf.minute,tf.second
		formatted_time = time(hour,min,sec)
		return datetime.combine(self.date_field,formatted_time)

	def start(self):
		self.clock_started = True
		self.date_field = datetime.now().date()
		self.time_record = datetime.now().time()
		self.save()

	def stop(self):
		self.clock_started = False
		diff = self.difference_in_seconds(self.date_field,self.time_record)
		self.duration_in_seconds += diff
		self.save()

	
	def difference_in_seconds(self,date,t):
		hour,min,sec = t.hour,t.minute,t.second
		formatted_time = time(hour,min,sec)
		dn = datetime.now()
		dt = datetime.combine(date,formatted_time)
		return (dn-dt).seconds

	def hit_timer(self):
		self.stop() if self.clock_started else self.start()

	def get_duration_in_seconds(self):
		return self.duration_in_seconds






