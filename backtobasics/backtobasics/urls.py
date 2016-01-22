from django.conf.urls import patterns, include, url
from django.conf import settings

# urls
from api.project.views import APIProjectView,APIProjectListView,APIProjectCreateView,APIProjectDeleteView,APIProjectUpdate
from api.task.views import (
		APITaskListView,
		APITaskEntryCreate,
		APITaskEntries,
		APITaskCreate,
		APIFindTaskById,
		APITaskEntryHitTimer,
		APITaskEntryDelete
	)

from api.customer.views import APICustomerListView

# django
from django.contrib import admin
admin.autodiscover()

# main
urlpatterns = patterns('',
    url(r'^admin/', include(admin.site.urls)),
)

# home
urlpatterns += patterns('home.views',
	url(r'^$', 'home',name='home'),
)

# media
urlpatterns += patterns('',
    (r'^media/(?P<path>.*)$', 'django.views.static.serve', {'document_root': settings.MEDIA_ROOT}))

# api 
urlpatterns += patterns('api.project',
	# projects
	url(r'^api/project/(?P<id>\d+)/$',APIProjectView.as_view()),
	url(r'^api/projects/$',APIProjectListView.as_view()),
	url(r'^api/projects/create/$',APIProjectCreateView.as_view()),
	url(r'^api/projects/update/(?P<id>\d+)/$',APIProjectUpdate.as_view()),
	url(r'^api/projects/delete/(?P<id>\d+)/$',APIProjectDeleteView.as_view()),
	# customers
	url(r'^api/customers/$',APICustomerListView.as_view()),
	# tasks
	url(r'^api/tasks/(?P<id>\d+)/$',APIFindTaskById.as_view()),
	url(r'^api/tasks/$',APITaskListView.as_view()),
	url(r'^api/tasks/create/$',APITaskCreate.as_view()),
	# taskentries
	url(r'^api/task/(?P<id>\d+)/entry/create/$',APITaskEntryCreate.as_view()),
	url(r'^api/task/entries/$',APITaskEntries.as_view()),
	url(r'^api/task/entries/(?P<id>\d+)/hit-timer/$',APITaskEntryHitTimer.as_view()),
	url(r'^api/task/entries/delete/(?P<id>\d+)/$',APITaskEntryDelete.as_view()),
)
# auth
urlpatterns += patterns('authentication.views',
	url(r'^login/$','login',name='login'),
	url(r'^logout/$','logout',name='logout'),
)

# auth
urlpatterns += patterns('task.views',
	url(r'^tasks/$','tasks',name='tasks'),
) 

# projects
urlpatterns += patterns('project.views',
	url(r'^projects/$','projects',name='projects'),
	url(r'^projects/delete/(?P<id>\d+)/$','project_delete',name='project_delete'),
	url(r'^projects/update/(?P<id>\d+)/$','project_update',name='project_update'),
	url(r'^projects/create/$','project_create',name='project_create'),
) 

# customers
urlpatterns += patterns('customer.views',
	url(r'^customers/$','customers',name='customers'),
) 