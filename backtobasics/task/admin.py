from django.contrib import admin
from models import Task,TaskEntry

class TaskAdmin(admin.ModelAdmin): 
	list_display = ['name']
	class Meta:
		model = Task

admin.site.register(Task,TaskAdmin)

class TaskEntryAdmin(admin.ModelAdmin):
	list_display = ['note','date_field','time_record']
	class Meta:
		model = TaskEntry

admin.site.register(TaskEntry,TaskEntryAdmin)
