# rest
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.authentication import SessionAuthentication
from rest_framework.permissions import IsAuthenticated

# app
from api.helper.helper_mixin import ModelListMixin

# serializers
from serializers import TaskSerializer,TaskEntrySerializer



# tasks
class APIFindTaskById(ModelListMixin,APIView):
	authentication_classes = (SessionAuthentication,)
	permission_classes = (IsAuthenticated,)

	def get(self,request,id):
		task = self.get_task_by_id(request,id)
		if task:
			serializer_class = TaskSerializer
			serialized_task = TaskSerializer(task).data
			return Response(serialized_task,status=status.HTTP_200_OK)
		return Response('failure, there were no tasks under your username')

class APITaskListView(ModelListMixin,APIView):
	authentication_classes = (SessionAuthentication,)
	permission_classes = (IsAuthenticated,)

	def get(self,request,format=None):
		tasks = self.get_user_tasks(request.user)
		serializer_class = TaskSerializer
		serialized_tasks = TaskSerializer(tasks, many=True).data
		return Response(serialized_tasks)

class APITaskCreate(ModelListMixin,APIView):
	authentication_classes = (SessionAuthentication,)
	permission_classes = (IsAuthenticated,)

	def post(self,request):
		post = request.POST
		if post['project'] and post['name']:
			task,created = self.create_task(request,post['name'],post['project'])
			if created:
				serializer_class = TaskSerializer
				serialized_task = TaskSerializer(task).data
				return Response(serialized_task,status=status.HTTP_200_OK)

		return Response('Failure, make sure not to leave fields blank.')	


# task entries
class APITaskEntryCreate(ModelListMixin,APIView):
	authentication_classes = (SessionAuthentication,)
	permission_classes = (IsAuthenticated,)
	
	def post(self,request,id):
		form = request.POST
		task_entry,created = self.create_by_task_id(id,form)
		if created:
			return Response('You Successfully created the task entry')
		return Response('Failure')

class APITaskEntries(ModelListMixin,APIView):
	authentication_classes = (SessionAuthentication,)
	permission_classes = (IsAuthenticated,)

	def post(self,request):
		post = request.POST 
		task_entries,created = self.get_task_entries_by_user(request,post['taskID'])
		if created:
			serializer_class = TaskEntrySerializer
			serialized_task_entries = TaskEntrySerializer(task_entries,many=True).data
			return Response(serialized_task_entries,status=status.HTTP_200_OK)
		return Response('Failure, there were no tasks according to that id',status=status.HTTP_404_NOT_FOUND)








