from django.shortcuts import render

def customers(request):
	template = 'customer/index.html'
	context = {}
	return render(request,template,context)
