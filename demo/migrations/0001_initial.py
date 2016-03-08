# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Athlete',
            fields=[
                ('athlete_id', models.CharField(help_text=b'\xe8\xbf\x90\xe5\x8a\xa8\xe5\x91\x98\xe5\xad\xa6\xe5\x8f\xb7', max_length=12, serialize=False, primary_key=True)),
                ('name', models.CharField(help_text=b'\xe8\xbf\x90\xe5\x8a\xa8\xe5\x91\x98\xe5\x90\x8d\xe5\xad\x97', max_length=30)),
            ],
            options={
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='Class',
            fields=[
                ('class_id', models.IntegerField(help_text=b'\xe7\x8f\xad\xe7\xba\xa7 ID,\xe7\x90\x86\xe8\xae\xba\xe4\xb8\x8a\xe4\xb8\x8d\xe4\xbc\x9a\xe8\xb6\x85\xe8\xbf\x87 900 \xe4\xb8\xaa\xe7\x8f\xad\xe3\x80\x82', serialize=False, primary_key=True)),
                ('grade', models.CharField(help_text=b'\xe5\xb9\xb4\xe7\xba\xa7,\xe5\xa6\x82 2014', max_length=4)),
                ('major', models.CharField(help_text=b'\xe4\xb8\x93\xe4\xb8\x9a', max_length=30)),
                ('num', models.IntegerField(help_text=b'\xe7\x8f\xad\xe5\x88\xab,\xe7\x90\x86\xe8\xae\xba\xe4\xb8\x8a\xe5\x90\x8c\xe4\xb8\x93\xe4\xb8\x9a\xe7\x9a\x84\xe7\x8f\xad\xe4\xb8\x8d\xe4\xbc\x9a\xe8\xb6\x85\xe8\xbf\x87 90 \xe4\xb8\xaa')),
                ('rank', models.IntegerField(help_text=b'\xe6\x8e\x92\xe5\x90\x8d', null=True)),
                ('mark', models.IntegerField(help_text=b'\xe5\x8a\xa0\xe5\x88\x86\xe6\x83\x85\xe5\x86\xb5', null=True)),
            ],
            options={
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='Key',
            fields=[
                ('Key', models.CharField(help_text=b'\xe9\x85\x8d\xe7\xbd\xae ID', max_length=20, serialize=False, primary_key=True)),
                ('key_name', models.CharField(help_text=b'\xe9\x85\x8d\xe7\xbd\xae\xe5\x90\x8d\xe7\xa7\xb0', max_length=30)),
                ('value', models.CharField(help_text=b'\xe9\x85\x8d\xe7\xbd\xae\xe5\x80\xbc', max_length=30)),
            ],
            options={
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='Score',
            fields=[
                ('score_id', models.IntegerField(serialize=False, primary_key=True)),
                ('result', models.CharField(help_text=b'\xe6\x88\x90\xe7\xbb\xa9', max_length=15, null=True)),
                ('mark', models.IntegerField(help_text=b'\xe5\x8a\xa0\xe5\x88\x86\xe6\x83\x85\xe5\x86\xb5', null=True)),
                ('ext_mark', models.IntegerField(help_text=b'\xe7\xa0\xb4\xe6\xa0\xa1\xe3\x80\x81\xe9\x99\xa2\xe8\xae\xb0\xe5\xbd\x95\xe9\xa2\x9d\xe5\xa4\x96\xe5\x8a\xa0\xe5\x88\x86\xe6\x83\x85\xe5\x86\xb5', null=True)),
                ('rank', models.IntegerField(help_text=b'\xe6\x8e\x92\xe5\x90\x8d', null=True)),
                ('group', models.IntegerField(help_text=b'\xe6\x89\x80\xe5\xb1\x9e\xe7\xbb\x84\xe6\x95\xb0')),
                ('final', models.CharField(help_text=b'\xe6\x8e\x92\xe5\xba\x8f\xe4\xbe\x9d\xe6\x8d\xae,1 \xe4\xb8\xba\xe5\x86\xb3\xe8\xb5\x9b,0 \xe4\xb8\xba\xe5\x88\x9d\xe8\xb5\x9b', max_length=1, null=True)),
                ('athleteObject', models.ForeignKey(to='demo.Athlete')),
                ('classObject', models.ForeignKey(to='demo.Class')),
            ],
            options={
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='Sport',
            fields=[
                ('sport_id', models.IntegerField(help_text=b'\xe8\xbf\x90\xe5\x8a\xa8\xe9\xa1\xb9\xe7\x9b\xae ID', serialize=False, primary_key=True)),
                ('sport_name', models.CharField(help_text=b'\xe8\xbf\x90\xe5\x8a\xa8\xe9\xa1\xb9\xe7\x9b\xae\xe5\x90\x8d\xe7\xa7\xb0', max_length=30)),
                ('campus_rec', models.CharField(help_text=b'\xe6\xa0\xa1\xe8\xae\xb0\xe5\xbd\x95', max_length=20)),
                ('college_rec', models.CharField(help_text=b'\xe9\x99\xa2\xe8\xae\xb0\xe5\xbd\x95', max_length=20)),
                ('sort', models.CharField(help_text=b'\xe6\x8e\x92\xe5\xba\x8f\xe4\xbe\x9d\xe6\x8d\xae,1 \xe4\xb8\xba\xe9\xa1\xba\xe5\xba\x8f,0 \xe4\xb8\xba\xe9\x80\x86\xe5\xba\x8f', max_length=1)),
                ('format', models.CharField(help_text=b'1 \xe4\xb8\xba\xe6\x97\xb6\xe9\x97\xb4,0 \xe4\xb8\xba\xe9\x95\xbf\xe5\xba\xa6', max_length=1)),
                ('preliminary', models.CharField(help_text=b'\xe6\x98\xaf\xe5\x90\xa6\xe6\x9c\x89\xe5\x88\x9d\xe8\xb5\x9b,1 \xe4\xb8\xba\xe6\x9c\x89,0 \xe4\xb8\xba\xe6\xb2\xa1\xe6\x9c\x89', max_length=1)),
                ('score_add', models.CharField(help_text=b'\xe5\x8a\xa0\xe5\x88\x86\xe7\xbb\x86\xe5\x88\x99', max_length=30)),
                ('group_num', models.IntegerField(help_text=b'\xe7\xbb\x84\xe6\x95\xb0,\xe7\x90\x86\xe8\xae\xba\xe4\xb8\x8a\xe4\xb8\x8d\xe4\xbc\x9a\xe8\xb6\x85\xe8\xbf\x87 90 \xe7\xbb\x84')),
                ('rise', models.IntegerField(help_text=b'\xe6\x99\x8b\xe7\xba\xa7\xe4\xba\xba\xe6\x95\xb0,\xe7\x90\x86\xe8\xae\xba\xe4\xb8\x8a\xe4\xb8\x8d\xe4\xbc\x9a\xe8\xb6\x85\xe8\xbf\x87 100.')),
            ],
            options={
            },
            bases=(models.Model,),
        ),
        migrations.AddField(
            model_name='score',
            name='sportObject',
            field=models.ForeignKey(to='demo.Sport'),
            preserve_default=True,
        ),
        migrations.AlterUniqueTogether(
            name='score',
            unique_together=set([('sportObject', 'classObject', 'athleteObject')]),
        ),
        migrations.AddField(
            model_name='athlete',
            name='classObject',
            field=models.ForeignKey(to='demo.Class'),
            preserve_default=True,
        ),
    ]
