#! /usr/bin/env python
# -*- coding: utf-8 -*-

from django.shortcuts import render
from django.views import generic
from demo.models import *
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
import json

# Create your views here.

# def edit_sport(request):
# 	return render(request,'demo/edit_competition.html') # 此处设置维护时间

class EditSportView(generic.ListView):
	template_name = 'demo/edit_competition.html'
	context_object_name = 'latest_sport_list'

	def get_queryset(self):
		"""Return the last five published questions."""
		return Sport.objects.order_by('-sport_id')

# 必须加上@csrf_exempt，不然会出现ajax请求得到403错误的结果
@csrf_exempt
def view_sport(request):
	try:
		# You're returning strings directly from create_transaction inside the POST block. You need to wrap them in an HttpResponse.
		# return json.dumps({"haha":"haha"})
		sport_name = request.POST['name']
		sport_object = Sport.objects.all().get(sport_name=sport_name)
		# return "haha"
		campus_rec = sport_object.campus_rec
		college_rec = sport_object.college_rec
		sort = sport_object.sort
		format = sport_object.format
		preliminary = sport_object.preliminary
		score_add = sport_object.score_add
		group_num = sport_object.group_num
		rise = sport_object.rise
		
		return_value ={
		"sport_name":sport_name,
		"campus_rec":campus_rec,
		"college_rec":college_rec,
		"sort":sort,
		"format":format,
		"preliminary":preliminary,
		"score_add":score_add,
		"group_num":group_num,
		"rise":rise
		}
		return HttpResponse(json.dumps(return_value))
		# return json.dumps(return_value)
	except Exception,ex:
		return HttpResponse(Exception)

@csrf_exempt
def add_sport(request):
	try:
		# return HttpResponse("haha")
		sport_name = request.POST['name']
		exist = len(Sport.objects.all().filter(sport_name=sport_name))
		if exist == 1:
			return HttpResponse("已存在相同名字的记录")
		largest = 0
		for sport in Sport.objects.all():
			temp = sport.sport_id
			if temp >largest:
				largest = temp
		sport_id = largest + 1 
		campus_rec = request.POST['campus_rec']
		college_rec = request.POST['college_rec']
		sort = request.POST['sort']
		format = request.POST['format']
		preliminary = request.POST['preliminary']
		score_add = request.POST['score_add']
		group_num = request.POST['group_num']
		rise = request.POST['rise']
		# return HttpResponse("haha")
		Sport.objects.create(sport_id=sport_id,sport_name=sport_name,campus_rec=campus_rec,college_rec=college_rec,
			sort=sort,format=format,preliminary=preliminary,score_add=score_add,group_num=group_num,
			rise=rise)
		return HttpResponse("添加成功")
	except Exception,ex:
		return HttpResponse(Exception)

@csrf_exempt
def del_sport(request):
	try:
		sport_name = request.POST['name']
		state = Sport.objects.all().get(sport_name=sport_name).delete()
		return HttpResponse("已经成功删除!") 
	except Exception,ex:
		return HttpResponse(Exception)

@csrf_exempt
def change_sport(request):
	# 既然option里面存在，那么就肯定存在这个name的sport
	try:
		sport_name = request.POST['name']
		campus_rec = request.POST['campus_rec']
		college_rec = request.POST['college_rec']
		sort = request.POST['sort']
		format = request.POST['format']
		preliminary = request.POST['preliminary']
		score_add = request.POST['score_add']
		group_num = request.POST['group_num']
		rise = request.POST['rise']
		sport_object = Sport.objects.all().get(sport_name=sport_name)
		sport_object.sport_name = sport_name
		sport_object.campus_rec = campus_rec
		sport_object.college_rec = college_rec
		sport_object.sort = sort
		sport_object.format = format
		sport_object.preliminary = preliminary
		sport_object.score_add = score_add
		sport_object.group_num = group_num
		sport_object.rise = rise
		sport_object.save()
		return HttpResponse("修改成功") 
	except Exception,ex:
		return HttpResponse(Exception) 


def sample(request):
	latest_sport_list = Sport.objects.order_by('-sport_id')
	context = {
		'latest_sport_list':latest_sport_list,
	}
	return render(request,'sample/sample.html',context)









