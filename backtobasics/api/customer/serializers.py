from rest_framework import serializers, routers, viewsets,permissions

from customer.models import Customer

class CustomerSerializer(serializers.ModelSerializer):
	class Meta:
		model = Customer


	

