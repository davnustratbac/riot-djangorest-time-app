from django.shortcuts import render,redirect
from django.contrib.auth import authenticate
from django.contrib.auth import login as auth_login
from django.contrib.auth import logout as auth_logout
from django.contrib import messages
from forms import UserLoginForm

def login(request):
	post = request.POST
	login_form = UserLoginForm(post or None)

	if login_form.is_valid():

		username = login_form.cleaned_data['username']
		password = login_form.cleaned_data['password']

		user_auth = authenticate(username=username,password=password)

		if user_auth:
			auth_login(request,user_auth)
			messages.success(request,'You successfully logged in!')
			return redirect('home')
		else:
			messages.error(request,'Login Failed')
	
	template = 'authentication/index.html'
	context = {'login_form':login_form}
	return render(request,template,context)


def logout(request):
	auth_logout(request)
	messages.success(request,'successfully logged out')
	return redirect('home')
	
