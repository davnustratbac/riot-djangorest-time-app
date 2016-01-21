from rest_framework import serializers, routers, viewsets,permissions
from task.models import Task,TaskEntry
from api.project.serializers import ProjectSerializer

class TaskEntrySerializer(serializers.ModelSerializer):
	class Meta:
		model = TaskEntry

class TaskSerializer(serializers.ModelSerializer):
	project = ProjectSerializer()
	has_entries = serializers.SerializerMethodField('has_task_entries')

	def has_task_entries(self, task):
		return task.has_task_entries()

	class Meta:
		model = Task
		fields = ['id','project','name','user','has_entries']
		

	

