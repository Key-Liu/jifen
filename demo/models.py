#! /usr/bin/env python
# -*- coding: utf-8 -*-

from django.db import models
from django.utils.decorators import classonlymethod
import urllib

# Create your models here.
class Sport(models.Model):
		sport_id = models.IntegerField(primary_key=True,help_text="运动项目 ID",default=1)
		sport_name = models.CharField(max_length=30,help_text="运动项目名称")
		campus_rec = models.CharField(max_length=20,help_text="校记录")
		college_rec = models.CharField(max_length=20,help_text="院记录")
		sort = models.CharField(max_length=1,help_text="排序依据,1 为顺序,0 为逆序")
		format = models.CharField(max_length=1,help_text="1 为时间,0 为长度")
		preliminary = models.CharField(max_length=1,help_text="是否有初赛,1 为有,0 为没有")
		score_add = models.CharField(max_length=30,help_text="加分细则")
		group_num = models.IntegerField(help_text="组数,理论上不会超过 90 组")
		rise = models.IntegerField(help_text="晋级人数,理论上不会超过 100.")

		def __unicode__(self):
			return unicode(self.sport_name) + u""

class Class(models.Model):
	class_id = models.IntegerField(primary_key=True,help_text="班级 ID,理论上不会超过 900 个班。")
	grade = models.CharField(max_length=4,help_text="年级,如 2014")
	major = models.CharField(max_length=30,help_text="专业")
	num = models.IntegerField(help_text="班别,理论上同专业的班不会超过 90 个")
	rank = models.IntegerField(help_text="排名",null=True)
	mark = models.IntegerField(help_text="加分情况",null=True)

	def __unicode__(self):
		return unicode(self.major) + unicode(self.grade) + " " + unicode(self.num) + u"班" 

class Athlete(models.Model):
	athlete_id = models.CharField(max_length=12,primary_key=True,help_text="运动员学号")
	name = models.CharField(max_length=30,help_text="运动员名字")
	classObject = models.ForeignKey(Class)


	def __unicode__(self):
		return self.athlete_id + " " + self.name

class Score(models.Model):
	score_id = models.AutoField(primary_key=True,default=1)
	sportObject = models.ForeignKey(Sport)
	classObject = models.ForeignKey(Class)
	athleteObject = models.ForeignKey(Athlete)
	result = models.CharField(max_length=15,help_text="成绩",null=True)
	mark = models.IntegerField(help_text="加分情况",null=True)
	ext_mark = models.IntegerField(help_text="破校、院记录额外加分情况",null=True)
	rank = models.IntegerField(help_text="排名",null=True)
	group = models.IntegerField(help_text="所属组数")
	final = models.CharField(max_length=1,help_text="排序依据,1 为决赛,0 为初赛",null=True)

	def __unicode__(self):
		return unicode(self.sportObject) + unicode(self.classObject) + unicode(self.athleteObject)

	class Meta:
		unique_together = ("sportObject", "classObject","athleteObject","final")

class Key(models.Model):# 配置表可以用来以后设置一些全局信息，例如运动会时间等等
	Key = models.CharField(max_length=20,primary_key=True,help_text="配置 ID")
	key_name = models.CharField(max_length=30,help_text="配置名称")
	value = models.CharField(max_length=30,help_text="配置值")

	def __unicode__(self):
		return self.key_name


