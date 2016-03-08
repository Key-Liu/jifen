#! /usr/bin/env python
#coding:utf-8

from django.shortcuts import render
from django.views import generic
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
from demo.models import *
from django.template import loader,Context
import json
import types
import xlwt
# Create your views here.

def rank(request):
	latest_score_list = Score.objects.order_by('-score_id')
	context = {
		'latest_score_list':latest_score_list,
	}
	return render(request,'rank/rank.html',context)

def rank_sport(request):
	latest_score_list = Score.objects.order_by('-score_id')
	latest_sport_list = Sport.objects.order_by('-sport_id')
	context = {
		'latest_score_list':latest_score_list,
		'latest_sport_list':latest_sport_list,
	}
	return render(request,'rank/rank_sport.html',context)

def rank_class(request):
	latest_score_list = Score.objects.order_by('-score_id')
	context = {
		'latest_score_list':latest_score_list,
	}
	return render(request,'rank/rank_class.html',context)

def rank_sport_detail(request,sport_id):
	try:
		sport = Sport.objects.get(sport_id=sport_id)
		format = sport.format
		scorelist = Score.objects.filter(sportObject=sport).order_by('-final','rank')
	except Score.DoesNotExist:
		raise Http404
	return render(request,'rank/rank_sport_detail.html',{
		'sport':sport,
		'format':format,
		'scorelist':scorelist,
		'sport_id':sport_id,
		})

def rank_sport_default(request):
	latest_sport_list = Sport.objects.order_by('-sport_id')
	context = {
		'latest_sport_list':latest_sport_list,
	}
	return render(request,'rank/rank_sport_default.html',context)

@csrf_exempt
def rank_class_compute(request):
	try:
		value = request.POST['value']
		if value=="test":
			class_list = Class.objects.all()
			for class_l in class_list:
				score_list = Score.objects.filter(classObject=class_l)
				mark = 0
				for score in score_list:
					if type(score.mark) is types.NoneType:
						continue
					if type(score.ext_mark) is types.NoneType:
						continue
					mark = score.mark + score.ext_mark + mark
				class_l.mark = mark
				class_l.save()
			
			

			class_list = Class.objects.order_by('-mark')

			n = class_list.count()
			i = 0
			while i < n:
				q = class_list[i]
				if i > 0:
					p = class_list[i-1]
					if q.mark==p.mark:
						q.rank = p.rank
						q.save()
					else:
						q.rank = i + 1
						q.save()
				else:
					q.rank = i + 1
					q.save()
				i = i + 1

		return HttpResponse("计算成功")
	
	except Exception,ex:
		
		return HttpResponse("计算失败")


def rank_class_detail(request):
	latest_class_list = Class.objects.order_by('rank')
	context = {
		'latest_class_list':latest_class_list,
	}
	return render(request,'rank/rank_class_detail.html',context)

def rank_class_default(request):
	latest_class_list = Class.objects.order_by('mark')
	context = {
		'latest_class_list':latest_class_list,
	}
	return render(request,'rank/rank_class_default.html',context)

# def rank_sport_csv(request,sport_id):
#     response = HttpResponse(content_type='text/csv')
#     response['Content-Disposition'] = 'attachment; filename="rank_sport.csv"'
#     sport = Sport.objects.get(sport_id=sport_id)
#     format = sport.format
#     scorelist = Score.objects.filter(sportObject=sport).order_by('-final','rank')
#     t = loader.get_template('rank/sport_rank.txt')
#     c = Context({
#     	'scorelist': scorelist,
#     	'sport': sport,
#     })
#     response.write(t.render(c))
#     return response

# def rank_class_csv(request):
#     response = HttpResponse(content_type='text/csv')
#     response['Content-Disposition'] = 'attachment; filename="rank_class.csv"'
#     class_list = Class.objects.order_by('-mark')
#     t = loader.get_template('rank/class_rank.txt')
#     c = Context({
#         'classlist': class_list,
#     })
#     response.write(t.render(c))
#     return response

def export_sport(request):
    response = HttpResponse(content_type='application/vnd.ms-excel')
    response['Content-Disposition'] = 'attachment; filename="项目排名.xls"'
    sport_list = Sport.objects.order_by('sport_id')
    workbook = xlwt.Workbook(encoding = 'utf-8')
    for sport in sport_list:
    	#注项目名称中有*会造成invalid worksheet name
    	worksheet = workbook.add_sheet(str(sport))
    	worksheet.write(0,0,label = '组号')
    	worksheet.write(0,1,label = '姓名')
    	worksheet.write(0,2,label = '学号')
    	worksheet.write(0,3,label = '班级')
    	worksheet.write(0,4,label = '成绩')
    	worksheet.write(0,5,label = '排名')
    	worksheet.write(0,6,label = '加分')
    	worksheet.write(0,7,label = '额外')
    	scorelist = Score.objects.filter(sportObject=sport).order_by('-final','rank')
    	i = 1
    	for score in scorelist:
    		if score.final == "0":
    			continue
    		if score.rank >8:
    			continue
    		if score.rank == 0:
    			continue
    		if type(score.rank) is types.NoneType:
    			continue
    		worksheet.write(i,0,label = score.group)
    		worksheet.write(i,1,label = score.athleteObject.name)
    		worksheet.write(i,2,label = score.athleteObject.athlete_id)
    		worksheet.write(i,3,label = str(score.classObject))
    		if score.sportObject.format == "1":
    			worksheet.write(i,4,label = score.result[0:2] + "'" + score.result[2:4] + '"' + score.result[4:6])
    		else:
    			worksheet.write(i,4,label = score.result)
    		worksheet.write(i,5,label = score.rank)
    		worksheet.write(i,6,label = score.mark)
    		worksheet.write(i,7,label = score.ext_mark)
    		i = i + 1
    workbook.save(response)
    return response

def export_class(request):
	response = HttpResponse(content_type='application/vnd.ms-excel')
	response['Content-Disposition'] = 'attachment; filename="班级排名.xls"'
	class_list = Class.objects.order_by('-mark')
	workbook = xlwt.Workbook(encoding = 'utf-8')
	worksheet = workbook.add_sheet('Class')
	worksheet.write(0,0,label = '班级')
	worksheet.write(0,1,label = '总分')
	worksheet.write(0,2,label = '排名')
	i = 1
	for class_item in class_list:
		if class_item.mark != 0:
			worksheet.write(i,0,label = str(class_item))
			worksheet.write(i,1,label = class_item.mark)
			worksheet.write(i,2,label = class_item.rank)
		i = i + 1
	workbook.save(response)
	return response