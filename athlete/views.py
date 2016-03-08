#! /usr/bin/env python
# -*- coding: utf-8 -*-

from django.shortcuts import render
from django.views import generic
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
from demo.models import *
import json
# Create your views here.

class AthleteView(generic.ListView):
	template_name = 'athlete/athlete_manage.html'
	context_object_name = 'latest_sport_list'

	def get_queryset(self):
		return Sport.objects.order_by('-sport_id')

def athleteview(request):
	latest_sport_list = Sport.objects.order_by('-sport_id')
	context = {
		'latest_sport_list':latest_sport_list,
	}
	return render(request,'athlete/athlete_manage.html',context)


@csrf_exempt
def view_sport(request):
	try:
		# You're returning strings directly from create_transaction inside the POST block. You need to wrap them in an HttpResponse.
		# return json.dumps({"haha":"haha"})
		sport_name = request.POST['name']
		sport_object = Sport.objects.all().get(sport_name=sport_name)
		sport_id = sport_object.sport_id
		# return "haha"
		campus_rec = sport_object.campus_rec
		college_rec = sport_object.college_rec
		sort = sport_object.sort
		format = sport_object.format
		preliminary = sport_object.preliminary
		score_add = sport_object.score_add
		group_num = sport_object.group_num
		rise = sport_object.rise
		score_list = Score.objects.filter(sportObject=sport_object)
		addednum = 0
		for score in score_list:
			if score.sportObject.preliminary=="1":
				if score.final=="0":
					addednum = addednum + 1
			if score.sportObject.preliminary=="0":
				addednum = addednum + 1
		
		return_value ={
		"sport_name":sport_name,
		"sport_id":sport_id,
		"campus_rec":campus_rec,
		"college_rec":college_rec,
		"sort":sort,
		"format":format,
		"preliminary":preliminary,
		"score_add":score_add,
		"group_num":group_num,
		"rise":rise,
		"addednum":addednum
		}
		return HttpResponse(json.dumps(return_value))
		# return json.dumps(return_value)
	except Exception,ex:
		return HttpResponse(Exception)

@csrf_exempt
def change_athlete(request):
	try:
		athlete_group = request.POST['group']
		athlete_nid = request.POST['nid']
		sport_id = request.POST['sport_id']
		athlete_object = Athlete.objects.all().get(athlete_id=athlete_nid)
		sport_object = Sport.objects.all().get(sport_id=sport_id)
		score_object = Score.objects.all().get(sportObject=sport_object,athleteObject=athlete_object)
		score_object.group = athlete_group;
		score_object.save();
		return HttpResponse("修改成功")
	except Exception,ex:
		return HttpResponse(Exception)

@csrf_exempt
def delete_athlete(request):
	try:
		athlete_nid = request.POST['nid']
		sport_id = request.POST['sport_id']
		athlete_object = Athlete.objects.all().get(athlete_id=athlete_nid)
		sport_object = Sport.objects.all().get(sport_id=sport_id)
		score_object = Score.objects.all().get(athleteObject=athlete_object,sportObject=sport_object)
		score_object.delete()
		return HttpResponse("删除成功")
	except Exception,ex:
		return HttpResponse(Exception)

def athletedetail(request,sport_id):
	try:
		sport = Sport.objects.get(sport_id=sport_id)
		scorelist = sport.score_set.order_by('group')
		classlist = Class.objects.all()
	except Score.DoesNotExist:
		raise Http404
	return render(request,'athlete/athlete_detail.html',{
		'sport':sport,
		'scorelist':scorelist,
		'classlist':classlist,
		'sport_id':sport_id,
		})

def athletedefault(request):
	latest_sport_list = Sport.objects.order_by('-sport_id')
	context = {
		'latest_sport_list':latest_sport_list,
	}
	return render(request,'athlete/athlete_default.html',context)

def addpage(request,sport_id):
	try:
		sport = Sport.objects.get(sport_id=sport_id)
		scorelist = sport.score_set.all()
		classlist = Class.objects.all()
	except Score.DoesNotExist:
		raise Http404
	return render(request,'athlete/athlete_add.html',{
		'sport':sport,
		'scorelist':scorelist,
		'classlist':classlist,
		'sport_id':sport_id,
		})

@csrf_exempt
def get_athlete(request):
	try:
		# You're returning strings directly from create_transaction inside the POST block. You need to wrap them in an HttpResponse.
		# return json.dumps({"haha":"haha"})
		athlete_id = request.POST['nid']
		athlete_object = Athlete.objects.get(athlete_id=athlete_id)
		athlete_name = athlete_object.name
		athlete_class = athlete_object.classObject
		athlete_class_major = athlete_class.major
		athlete_class_grade = athlete_class.grade
		athlete_class_num = athlete_class.num

		return_value = {
		"athlete_name":athlete_name,
		"athlete_class_major":athlete_class_major,
		"athlete_class_grade":athlete_class_grade,
		"athlete_class_num":athlete_class_num,
		}
		return HttpResponse(json.dumps(return_value))
		# return json.dumps(return_value)
	except Exception,ex:
		return HttpResponse()

@csrf_exempt
def add_athlete(request):
	try:
		athlete_group = request.POST['group']
		athlete_nid = request.POST['nid']
		sport_id = request.POST['sport_id']
		sport_object = Sport.objects.all().get(sport_id=sport_id)
		athlete_object = Athlete.objects.all().get(athlete_id=athlete_nid)
		class_object = athlete_object.classObject
		exist = len(Score.objects.all().filter(athleteObject=athlete_object,sportObject=sport_object))
		largest = 0
		for score in Score.objects.all():
			temp = score.score_id
			if temp > largest:
				largest = temp
		score_id = largest + 1 
		if exist == 1:
			return HttpResponse("已存在相同名字的记录")

		if sport_object.preliminary == '1':	
			Score.objects.create(sportObject=sport_object,classObject=class_object,athleteObject=athlete_object,group=athlete_group,final=0,score_id=score_id)
		if sport_object.preliminary == '0':
			Score.objects.create(sportObject=sport_object,classObject=class_object,athleteObject=athlete_object,group=athlete_group,final=1,score_id=score_id)

		return HttpResponse("添加成功")
	except Exception,ex:
		return HttpResponse(Exception)