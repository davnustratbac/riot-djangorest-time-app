from django.shortcuts import render,redirect
from models import Project
from customer.models import Customer
from forms import ProjectForm
from django.contrib import messages
from django.contrib.auth.decorators import login_required

def project_delete(request,id):
	try:
		project = Project.objects.get(id=id)
	except:
		project = None 

	if project:
		project.delete()
		messages.success(request,'%s successfully deleted' % project)
	else:
		messages.error(request,'%s was not deleted' % project)

	return redirect('projects')

def project_update(request,id):
	post = request.POST 

	try:
		project = Project.objects.get(id=id)
	except:
		project = None

	try:
		name = post['name']
	except:
		name = None
	
	if post and name:
		project.name = name
		project.save()
		messages.success(request,'%s was successfully updated' % project)

	return redirect('projects')

def project_create(request):
	post = request.POST

	try:
		customer = post['select']
		name = post['project']
	except:
		customer = None
		name = None

	try:
		customer = Customer.objects.get(company=str(customer))
	except:
		customer = None

	if post and customer and name:
		project,created = Project.objects.get_or_create(customer=customer,name=name)
		if created:
			messages.success(request,'Project: %s : %s successfully created!' % (name,customer))
		else:
			messages.error(request,'%s : %s already exists' % (name,customer))
		
		if not customer and name:
			messages.error(request,'Error, make sure to have a customer and a name for customer.')

	return redirect('projects')

@login_required(login_url='login')
def projects(request):
	template = 'project/index.html'
	projects = Project.objects.all()
	customers = Customer.objects.all()
	context = {'projects' : projects,'customers' : customers}
	return render(request,template,context)
