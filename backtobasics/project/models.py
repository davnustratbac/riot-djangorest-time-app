from django.db import models
from customer.models import Customer


class Project(models.Model):
	name = models.CharField(max_length=400,blank=True,null=True)
	customer = models.ForeignKey(Customer,blank=True,null=True)

	def __unicode__(self):
		return "Company: %s Project: %s" % (self.customer.company,self.name)