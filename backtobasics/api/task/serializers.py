from rest_framework import serializers, routers, viewsets,permissions
from task.models import Task,TaskEntry
from api.project.serializers import ProjectSerializer

class TaskEntrySerializer(serializers.ModelSerializer):
	datetime_last_save = serializers.SerializerMethodField('datetime_last_save')

	def datetime_last_save(self,entry):
		return entry.datetime_last_save()

	class Meta:
		model = TaskEntry
		fields = ['id','task','datetime_last_save','date_field','time_record','duration_in_seconds','clock_started','note']

class TaskSerializer(serializers.ModelSerializer):
	project = ProjectSerializer()
	task_entry_count = serializers.SerializerMethodField('task_entry_count')
	has_entries = serializers.SerializerMethodField('has_task_entries')

	def task_entry_count(self, task):
		return task.task_entry_count()
		
	def has_task_entries(self, task):
		return task.has_task_entries()

	class Meta:
		model = Task
		fields = ['id','project','name','user','has_entries','task_entry_count']
		

	

