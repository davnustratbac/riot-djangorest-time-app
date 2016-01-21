# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('customer', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Project',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(max_length=400, null=True, blank=True)),
                ('customer', models.ForeignKey(blank=True, to='customer.Customer', null=True)),
            ],
            options={
            },
            bases=(models.Model,),
        ),
    ]
