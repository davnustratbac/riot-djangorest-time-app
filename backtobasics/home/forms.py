from django import forms
from django.forms import ModelForm
from task.models import TaskEntry,Task
from project.models import Project
from customer.models import Customer

class CustomerForm(forms.ModelForm):
	class Meta:
		model = Customer

class ProjectForm(forms.ModelForm):
	class Meta:
		model = Project

class TaskEntryForm(forms.ModelForm):
	class Meta:
		model = TaskEntry

class TaskForm(forms.ModelForm):
	class Meta:
		model = Task