from django.db import models

class Customer(models.Model):
	company = models.CharField(max_length=100,blank=True,null=True)
	address1 = models.CharField(max_length=40,blank=True,null=True)
	address2 = models.CharField(max_length=40,blank=True,null=True)
	address3 = models.CharField(max_length=40,blank=True,null=True)
	city    = models.CharField(max_length=15,blank=True,null=True)
	state   = models.CharField(max_length=10,blank=True,null=True)
	zip     = models.CharField(max_length=400,blank=True,null=True)
	phone1  = models.CharField(max_length=40,blank=True,null=True)
	phone2  = models.CharField(max_length=40,blank=True,null=True)
	fax1    = models.CharField(max_length=40,blank=True,null=True)
	fax2    = models.CharField(max_length=40,blank=True,null=True)
	email   = models.CharField(max_length=40,blank=True,null=True)
	url     = models.CharField(max_length=40,blank=True,null=True)

	def __unicode__(self):
		return self.company

 
 
 
 
    
   
     
  
  
    
    
   
     