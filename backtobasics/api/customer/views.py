from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status

from api.helper.helper_mixin import ModelListMixin
from serializers import CustomerSerializer

class APICustomerListView(ModelListMixin,APIView):       
	def get(self,request,format=None):
		serializer_class = CustomerSerializer
		customers = CustomerSerializer(self.get_customer_list(), many=True).data
		return Response(customers)
