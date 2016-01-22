from django.shortcuts import render
from django.contrib.auth.decorators import login_required

@login_required(login_url='login')
def customers(request):
	template = 'customer/index.html'
	context = {}
	return render(request,template,context)
