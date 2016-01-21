from rest_framework import serializers, routers, viewsets,permissions
from project.models import Project

from api.customer.serializers import CustomerSerializer

class ProjectSerializer(serializers.ModelSerializer):
	customer = CustomerSerializer()
	class Meta:
		model = Project
		fields = ['id','name','customer']
		

	

