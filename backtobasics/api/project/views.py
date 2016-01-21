from rest_framework.authentication import SessionAuthentication
from rest_framework.permissions import IsAuthenticated


from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status

from django.shortcuts import get_object_or_404

from customer.models import Customer
from project.models import Project

from api.customer.serializers import CustomerSerializer
from api.project.serializers import ProjectSerializer

from api.helper.helper_mixin import ModelListMixin

class APIProjectListView(ModelListMixin,APIView):
	authentication_classes = (SessionAuthentication,)
	permission_classes = (IsAuthenticated,)

	def get(self,request):

		serializer_class = ProjectSerializer
		projects = ProjectSerializer(self.get_project_list(),many=True).data 
		return Response(projects)

class APIProjectView(APIView):
	authentication_classes = (SessionAuthentication,)
	permission_classes = (IsAuthenticated,)

	def find_project(self,id):
		try:
			project = Project.objects.get(id=id)
		except:
			project = None
		return project

	def get(self,request,id):
		serializer_class = ProjectSerializer
		project = ProjectSerializer(self.find_project(id)).data

		return Response(project)

class APIProjectCreateView(APIView):
	authentication_classes = (SessionAuthentication,)
	permission_classes = (IsAuthenticated,)

	def post(self,request):
		post = request.POST 
		name = post['name']

		try:
			customer = Customer.objects.get(company=post['customer'])
		except:
			customer = None


		project,created = Project.objects.get_or_create(name=name,customer=customer)

		if created:
			serializer_class = ProjectSerializer
			serialized_project = ProjectSerializer(project).data
			return Response(serialized_project)
		return Response('There was an error')

class APIProjectDeleteView(APIView):
	authentication_classes = (SessionAuthentication,)
	permission_classes = (IsAuthenticated,)

	def post(self,request,id):
		try:
			project = Project.objects.get(id=id)
		except:
			project = None

		if project:
			project.delete()
			return Response('Successful deletion',status=status.HTTP_200_OK)
		return Response(status=status.HTTP_404_NOT_FOUND)












