from django import forms

class UserLoginForm(forms.Form):
	username = forms.CharField(widget=forms.TextInput(attrs={
		'id' : 'username',
		"name" : "username",
		"class" : "form-control",
		"placeholder" : "Enter Username",
		"type" : "text",
	}))

	password = forms.CharField(widget=forms.TextInput(attrs={
		'id' : 'password',
		"name" : "password",
		"class" : "form-control",
		"placeholder" : "Enter Password",
		"type" : "password",
	}))