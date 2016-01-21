# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
from django.conf import settings


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('project', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Task',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(max_length=40, null=True, blank=True)),
                ('project', models.ForeignKey(blank=True, to='project.Project', null=True)),
                ('user', models.ForeignKey(blank=True, to=settings.AUTH_USER_MODEL, null=True)),
            ],
            options={
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='TaskEntry',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('date_field', models.DateField(auto_now_add=True, null=True)),
                ('time_record', models.TimeField(auto_now_add=True, null=True)),
                ('duration_in_seconds', models.IntegerField(default=0, null=True, blank=True)),
                ('clock_started', models.BooleanField(default=False)),
                ('note', models.CharField(max_length=400, null=True, blank=True)),
                ('task', models.ForeignKey(blank=True, to='task.Task', null=True)),
            ],
            options={
            },
            bases=(models.Model,),
        ),
    ]
