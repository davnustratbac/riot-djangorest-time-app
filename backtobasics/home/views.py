from django.shortcuts import render
from forms import CustomerForm,ProjectForm,TaskForm,TaskEntryForm

def home(request):
	template = 'home/index.html'
	context = {}
	return render(request,template,context)
