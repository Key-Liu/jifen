#! /usr/bin/env python
# -*- coding: utf-8 -*-
from django.http import Http404
from django.shortcuts import render
from django.views import generic
from loggrade.models import *
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
import json

# Create your views here.
class LogGradeView(generic.ListView):
	template_name = 'loggrade/view.html'         # 在templates目录下找
	context_object_name = 'latest_sport_list'

	def get_queryset(self):
		"""Return the last five published questions."""
		return Sport.objects.order_by('-sport_id')

# 必须加上@csrf_exempt，不然会出现ajax请求得到403错误的结果
# 获取体育项目信息
@csrf_exempt
def view_sport(request):
  try:
  	sport_id = request.POST['sport_id']
	sport_object = Sport.objects.get(sport_id=sport_id)
	sport_name = sport_object.sport_name
	group_num = sport_object.group_num
	campus_rec = sport_object.campus_rec
	college_rec = sport_object.college_rec
	# 参赛人数
	if sport_object.preliminary == "1" :
		player_num = Score.objects.filter(sportObject=sport_object).count()-Score.objects.filter(sportObject=sport_object,final="1").count()
	else :
		player_num = Score.objects.filter(sportObject=sport_object).count()
	preliminary = sport_object.preliminary
	
	return_value = {
	"sport_name":sport_name,
	"group_num":group_num,
	"campus_rec":campus_rec,
	"college_rec":college_rec,
	"player_num":player_num,
	"preliminary":preliminary,
	}
	return HttpResponse(json.dumps(return_value))
		# return json.dumps(return_value)
  except Exception,ex:
	return HttpResponse(Exception)

@csrf_exempt
def login_preliminary(request,sport_id,group): 
	sport_object = Sport.objects.get(sport_id=sport_id)
	if sport_object.preliminary == "1" :
		format = sport_object.format
		groups = []
		group_num = sport_object.group_num
		for i in range(1,group_num+1) :
			groups.append(i)
	
		athletes = Score.objects.filter(sportObject=sport_object,group=group,final="0")
		return render(request,'loggrade/login_preliminary.html',{'groups':groups,'athletes':athletes,'group':group,'sport_id':sport_id,'format':format})
	else :
		return HttpResponse("该项目没有初赛，请到录入决赛成绩栏 录入决赛成绩")

@csrf_exempt
def login_score(request):
	try:
		sport_id = request.POST['sport_id']
		sport_object = Sport.objects.get(sport_id=sport_id)
		athlete_id = request.POST['athlete_id']  
		athlete_object = Athlete.objects.get(athlete_id=athlete_id)
		grade = athlete_id[:4]
		class_num = request.POST['class_num']
		class_object = Class.objects.get(grade=grade,num=class_num)
		group = request.POST['group']
		score_object = Score.objects.get(sportObject=sport_object,athleteObject=athlete_object,classObject=class_object,group=group,final="0")
		result = request.POST['result']
		# 成绩为长度时， 转为str(float())
		if sport_object.format == "0" and result != "0" and result != "-2"	:
			score_object.result = str(float(result))
		else :
			score_object.result = result
		score_object.save()
		# score_object.group = request.POST['group']
		return HttpResponse("录入成功") 
	except Exception, ex:
		return HttpResponse(Exception.message.tostring())

@csrf_exempt
def new_score(request):
	try:
		sport_id = request.POST['sport_id']
		sport_object = Sport.objects.get(sport_id=sport_id)
		athlete_id = request.POST['athlete_id']   #鸡巴玩意
		athlete_object = Athlete.objects.get(athlete_id=athlete_id)
		grade = athlete_id[:4]
		class_num = request.POST['class_num']
		class_object = Class.objects.get(grade=grade,num=class_num)
		result = request.POST['result']
		
		largest = 0
		for score in Score.objects.all():
			temp = score.score_id
			if temp > largest:
				largest = temp
		score_id = largest + 1 
		# 成绩为长度时， 转为str(float())
		if sport_object.format == "0" and result != "0" and result != "-2":
				result = str(float(result))

		if sport_object.preliminary == "1" :
			group = 1
 			exit = Score.objects.filter(sportObject=sport_object,classObject=class_object,athleteObject=athlete_object,final="1").count()
			if exit == 1 :
				return HttpResponse("已存在录入对象")
			Score.objects.create(score_id=score_id,sportObject=sport_object,classObject=class_object,athleteObject=athlete_object,result=result,group=group,final="1")
		else :
			group = request.POST['group']
			score_object = Score.objects.get(sportObject=sport_object,athleteObject=athlete_object,classObject=class_object,group=group,final="1")		
			score_object.result = result

			score_object.save()
		return HttpResponse("录入决赛成绩成功") 
	except Exception, ex:
		return HttpResponse(Exception.message.tostring())

@csrf_exempt
def change_score(request):
	try:
		sport_id = request.POST['sport_id']
		sport_object = Sport.objects.get(sport_id=sport_id)
		athlete_id = request.POST['athlete_id']   
		athlete_object = Athlete.objects.get(athlete_id=athlete_id)
		grade = athlete_id[:4]
		class_num = request.POST['class_num']
		class_object = Class.objects.get(grade=grade,num=class_num)
		result = request.POST['result']
		group = request.POST['group']
		# 成绩为长度时， 转为str(float())
		if sport_object.format == "0" and result != "0" and result != "-2":
				result = str(float(result))

		score_object = Score.objects.get(sportObject=sport_object,athleteObject=athlete_object,classObject=class_object,group=group,final="1")
		score_object.result = result
		score_object.save()
		return HttpResponse("修改决赛成绩成功") 
	except Exception, ex:
		return HttpResponse(Exception.message.tostring())

@csrf_exempt
def login_final(request,sport_id,group):

		sport_object = Sport.objects.get(sport_id=sport_id)
		format = sport_object.format
		rise_scorerank = 8
		final = ""
		riseList = []
		groups = []
		# return HttpResponse(sport_object)
		# 只有决赛的项目
		if sport_object.preliminary == "0" :
			final = "1"
			group_num = sport_object.group_num
			riseList = Score.objects.filter(sportObject=sport_object,final=final,group=group)
			for i in range(1,group_num+1) :
				groups.append(i)
		else :
		# 有初赛的项目
			final = "0"
			groups = [1]
			score_object = Score.objects.filter(sportObject=sport_object,final=final).exclude(result="0").exclude(result="-2")
			for i in range(0,8):
				if len(riseList) < rise_scorerank :
					riseList.extend(score_object.filter(rank=i+1))
				else : 
					break

		return render(request,'loggrade/login_final.html',{'riseList':riseList,'sport_id':sport_id,'format':format,'groups':groups,'group':group})

# 查看晋级名单
@csrf_exempt
def check_final(request,sport_id):
		sport_object = Sport.objects.get(sport_id=sport_id)

		objs = Score.objects.filter(sportObject=sport_object,final="0")
		num_preliminary = objs.count()



		for ob in objs :
			# objs得到的是副本，不能直接修改其属性值，故用b进行修改
			b = Score.objects.get(athleteObject=ob.athleteObject,sportObject=sport_object,final="0")
			b.ext_mark = 0
			b.mark = 0
			b.save()

		if sport_object.preliminary == "1" :
			# 处理初赛缺席/请假运动员
			absents = Score.objects.filter(sportObject=sport_object,final="0",result="-2")

			for ab in absents :
				ab.mark = -2
				ab.rank = num_preliminary
				ab.save()

			timeoff = Score.objects.filter(sportObject=sport_object,final="0",result="0")
			for tf in timeoff :
				tf.mark = 0
				tf.rank = num_preliminary
				tf.save()

			format = sport_object.format
			# return HttpResponse(sport_object)
			score_object = Score.objects.filter(sportObject=sport_object,final="0").exclude(result="0").exclude(result="-2")	
			# return HttpResponse(score_object)
			score_num = score_object.count()
			# return HttpResponse(score_num)
			if score_num == 0 :
				return render(request,'loggrade/check_final.html')
			
			riseList = []

			# rise_score 成绩排位
			rise_scorerank = 8
			# 晋级的排位
			rise_pos = score_num
			# return HttpResponse(score_num)
			# 先对各成绩排名 组成 score对象 list
			if sport_object.format == "1": 
				riseList = score_object.order_by('result')
				# return HttpResponse(riseList)
			else :
				resultList = []
				# return HttpResponse(riseList[0].result)
				# resultList为已排好序的成绩数组
				for i in range(0,score_num) :
					resultList.append(float(score_object[i].result))
					resultList = sorted(set(resultList),key=resultList.index)
					resultList.sort(reverse=True)
				# return HttpResponse(resultList)
				for result in resultList :	
					records = score_object.filter(result=result)
					if len(records) == 1:
						riseList.append(records[0])
					elif len(records) > 1 :
						riseList.extend(records)
			
			# return HttpResponse([i.athleteObject for i in riseList])
			# order_by() 所取对象列表是副本 只能读 不能写 get()能写
			# 写入排名
			score_obj = Score.objects.get(athleteObject=riseList[0].athleteObject,sportObject=sport_object,final="0")
			score_obj.rank = 1
			score_obj.save()
			# test = []
			
			for i in range(1,score_num):
				score_obj = Score.objects.get(athleteObject=riseList[i].athleteObject,sportObject=sport_object,final="0")
				# test.append(score_obj.athleteObject.name)
				if sport_object.format == "1" :
					if riseList[i].result == riseList[i-1].result :
						# riseList[i]  是副本  riseList[i-1].rank并没有改变
						score_obj_pre = Score.objects.get(athleteObject=riseList[i-1].athleteObject,sportObject=sport_object,final="0")
						score_obj.rank = score_obj_pre.rank
					
					else :
						score_obj.rank = i + 1

				elif sport_object.format == "0" :

					if float(riseList[i].result) == float(riseList[i-1].result) :
						# return HttpResponse(score_obj.athleteObject)
						score_obj_pre = Score.objects.get(athleteObject=riseList[i-1].athleteObject,sportObject=sport_object,final="0")
						score_obj.rank = score_obj_pre.rank
						# return HttpResponse(score_obj.rank)
					
					else :
						# return HttpResponse(score_obj.athleteObject)
						score_obj.rank = i + 1
						# return HttpResponse(score_obj.rank)
				
			# return HttpResponse(test)
				score_obj.save()

			# 未晋级的加1分
			List = riseList
			
			riseList = []

			for i in range(0,8):
				if len(riseList) < rise_scorerank :
					riseList.extend(score_object.filter(rank=i+1))
				else : 
					break

			List = List[len(riseList):]
			# return HttpResponse(List)
			for o in List :
				obj = Score.objects.get(athleteObject=o.athleteObject,sportObject=sport_object,final="0")
				obj.mark = 1
				obj.save()

			# 未晋级的加1分

			return render(request,'loggrade/check_final.html',{'riseList':riseList,'sport_id':sport_id,'format':format})
		else :
			return HttpResponse("该项目没有初赛，请到录入决赛成绩栏 录入决赛成绩")

@csrf_exempt
def cal_final(request,sport_id):
		sport_object = Sport.objects.get(sport_id=sport_id)
		mark_rule = sport_object.score_add.split('|')
		# rise_score 成绩排位
		rise_scorerank = 8
		format = sport_object.format
		# return HttpResponse(sport_object)
		objs = Score.objects.filter(sportObject=sport_object,final="1")
		for ob in objs :
			b = Score.objects.get(athleteObject=ob.athleteObject,sportObject=sport_object,final="1")
			b.ext_mark = 0
			b.save()
		# 处理决赛缺席/请假运动员
		absents = Score.objects.filter(sportObject=sport_object,final="1",result="-2")
		timeoff = Score.objects.filter(sportObject=sport_object,final="1",result="0")

		for ab in absents :
			ab.mark = mark_rule[rise_scorerank-1]
			if ab.sportObject.preliminary == "1" : 
				ab.rank = rise_scorerank
			else :
				ab.rank = 0
				ab.mark = -2
				ab.ext_mark = 0
			ab.save()
		for off in timeoff :
			off.mark = mark_rule[rise_scorerank-1]
			if off.sportObject.preliminary == "1" :
				off.rank = rise_scorerank
			else :
				off.rank = 0
				off.mark = 0
				off.ext_mark = 0
			off.save()

		score_object = Score.objects.filter(sportObject=sport_object,final="1").exclude(result="0").exclude(result="-2")
		# 只有决赛的情况  除前八名外其他加1分
		for o in score_object:
			obj = Score.objects.get(athleteObject=o.athleteObject,sportObject=sport_object,final="1")
			obj.mark = 1
			obj.save()
		# 只有决赛的情况  除前八名外其他加1分
	 	score_num = score_object.count()

		if score_num == 0 :
				return render(request,'loggrade/check_final.html')
		riseList = []
	
		if sport_object.format == "1": 
			riseList = score_object.order_by('result')
		else :
			resultList = []
				# return HttpResponse(riseList[0].result)
			for i in range(0,score_num) :
				resultList.append(float(score_object[i].result))
				resultList = sorted(set(resultList),key=resultList.index)
				resultList.sort(reverse=True)
			# return HttpResponse(resultList)
			for result in resultList :	
				records = score_object.filter(result=result)
				if len(records) == 1:
					riseList.append(records[0])
				elif len(records) > 1 :
					riseList.extend(records)
			# order_by() 所取对象列表是副本 只能读 不能写 get()能写
		score_obj = Score.objects.get(athleteObject=riseList[0].athleteObject,sportObject=sport_object,final="1")
		score_obj.rank = 1
		score_obj.mark = mark_rule[0]
		score_obj.save()	

		# if sport_object.format == "1":
		# 	if score_obj.result < sport_object.campus_rec :
		# 			score_obj.ext_mark = 13
		# 	elif score_obj.result < sport_object.college_rec :
		# 		 	score_obj.ext_mark = 10 
		# else:
		# 	if float(score_obj.result) > float(sport_object.campus_rec) :
		# 			score_obj.ext_mark = 13   
		# 	elif float(score_obj.result) > float(sport_object.college_rec) :
		# 		 	score_obj.ext_mark = 10
		# score_obj.save()

		# 给晋级运动员排名加分 
		# return HttpResponse(len(riseList))
		for i in range(1,score_num):
			score_obj = Score.objects.get(athleteObject=riseList[i].athleteObject,sportObject=sport_object,final="1")

			if sport_object.format == "1":

				if riseList[i].result == riseList[i-1].result :
					score_obj_pre = Score.objects.get(athleteObject=riseList[i-1].athleteObject,sportObject=sport_object,final="1")
					score_obj.rank = score_obj_pre.rank
				else :
					score_obj.rank = i + 1
			
				if riseList[i].result < sport_object.campus_rec :
					score_obj.ext_mark = 13
				elif riseList[i].result < sport_object.college_rec :
				 	score_obj.ext_mark = 10 
				else :
					score_obj.ext_mark = 0

			elif sport_object.format == "0" :

				if float(riseList[i].result) == float(riseList[i-1].result) :
					score_obj_pre = Score.objects.get(athleteObject=riseList[i-1].athleteObject,sportObject=sport_object,final="1")
					score_obj.rank = score_obj_pre.rank
				else :
					score_obj.rank = i + 1

				if float(riseList[i].result) > float(sport_object.campus_rec) :
					score_obj.ext_mark = 13   
				elif float(riseList[i].result) > float(sport_object.college_rec) :
				 	score_obj.ext_mark = 10
				else :
					score_obj.ext_mark = 0
			score_obj.save()

			# 加分规则给成绩前2-8名加分
			if score_obj.rank - 1 < rise_scorerank and score_obj.rank - 1 >= 0:
				score_obj.mark = mark_rule[score_obj.rank - 1]


			score_obj.save()

		riseList = []
		for i in range(0,8):
				if len(riseList) < rise_scorerank :
					riseList.extend(score_object.filter(rank=i+1))
				else : 
					break

		return render(request,'loggrade/cal_final.html',{'riseList':riseList,'sport_id':sport_id,'format':format})


@csrf_exempt
def delete_score(request):
	try:
		sport_name=request.POST['sport_name']
		sport_object = Sport.objects.get(sport_name=sport_name)
		athlete_id = request.POST['athlete_id']  
		athlete_object = Athlete.objects.get(athlete_id=athlete_id)
		grade = athlete_id[:4]
		class_num = request.POST['class_num']
		class_object = Class.objects.get(grade=grade,num=class_num)
		final = request.POST['final']
		score_object = Score.objects.get(sportObject=sport_object,athleteObject=athlete_object,classObject=class_object,final=final)
		# score_object.result = request.POST['result']
		# score_object.group = request.POST['group']
		score_object.delete()
		# score_object.group = request.POST['group']
		return HttpResponse("删除成功") 
	except Exception, ex:
		return HttpResponse(Exception.message.tostring())


