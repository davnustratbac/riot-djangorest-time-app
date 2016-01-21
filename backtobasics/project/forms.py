from django import forms
from customer.models import Customer 

class ProjectForm(forms.Form):

	name = forms.CharField(widget=forms.TextInput(attrs={
		'id' : 'name',
		"name" : "name",
		"class" : "form-control",
		"placeholder" : "Enter Project Name",
		"type" : "text",
	}))