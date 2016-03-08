# -*- coding: utf-8 -*-

from django.shortcuts import render
from django.views import generic
from demo.models import *
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
import json

class EditStudentView(generic.ListView):
    
    template_name = 'student/edit_student.html'
    context_object_name = 'latest_student_list'
    
    def get_queryset(self):
        try:
            all_athletes = Athlete.objects.all()
            return_value=[];
            
            for athlete_object in all_athletes:
                class_id = athlete_object.classObject.class_id
                athlete_id = athlete_object.athlete_id
                name = athlete_object.name
                class_object= Class.objects.all().get(class_id=class_id)
                grade = class_object.grade
                major = class_object.major
                num = class_object.num
                student={"athlete_id":athlete_id,"name":name,"major":major,"grade":grade,"num":num}
                return_value.append(student)

            return return_value
        except Exception,ex:
            return Exception

@csrf_exempt     
def edit_student(request):
    return render(request,'student/edit_student.html')     
    
    
@csrf_exempt
def view_student(self):
    try:
        all_athletes = Athlete.objects.all() 
        return_value=[]
        for athlete_object in all_athletes:
            class_id = athlete_object.classObject.class_id
            athlete_id = athlete_object.athlete_id
            name = athlete_object.name
            class_object= Class.objects.all().get(class_id=class_id)
            grade = class_object.grade
            major = class_object.major
            num = class_object.num
            student={"athlete_id":athlete_id,"name":name,"major":major,"grade":grade,"num":num}
            return_value.append(student)
            print return_value
        print return_value.__len__()
        return HttpResponse(json.dumps(return_value))
    except Exception,ex:
        return HttpResponse(Exception) 
    
    
@csrf_exempt
def search_student(request):
    try:  
        return_value=[]
        athlete_objects=[]
        data = request.POST['data']
        athlete_id_exist = len(Athlete.objects.all().filter(athlete_id=data))
        if athlete_id_exist == 1:
            athlete_objects.append(Athlete.objects.all())
            athlete_name_exist = len(Athlete.objects.all().filter(name=data))
            if athlete_name_exist == 0:
                pass
            else:
                athlete_objects.append(Athlete.objects.all())
        else:
            athlete_name_exist = len(Athlete.objects.all().filter(name=data))
            if athlete_name_exist == 0:
                data={"error":"没有匹配的项目"}
                return HttpResponse(json.dumps(data))
            else:
                print Athlete.objects.all()
                athlete_objects.append(Athlete.objects.all())
                print athlete_objects

        for athlete_object in athlete_objects[0]:
            if athlete_object.athlete_id ==data or athlete_object.name ==data:
                print athlete_object
                class_id = athlete_object.classObject.class_id
                class_object= Class.objects.all().get(class_id=class_id)
                name=athlete_object.name
                athlete_id = athlete_object.athlete_id
                grade = class_object.grade
                major = class_object.major
                num = class_object.num
                student={"athlete_id":athlete_id,"name":name,"major":major,"grade":grade,"num":num}
                return_value.append(student)
            print return_value
        return HttpResponse(json.dumps(return_value))
    except Exception,ex:
        return HttpResponse(Exception)     
         
    
@csrf_exempt    
def select_student_by_athlete_id(request):
    try:  
        athlete_id = request.POST['athlete_id']
        athlete_object = Athlete.objects.all().get(athlete_id=athlete_id)
        class_id = athlete_object.classObject.class_id
        class_object= Class.objects.all().get(class_id=class_id)

        name = athlete_object.name
        grade = class_object.grade
        major = class_object.major
        num = class_object.num
        
        return_value ={
        "athlete_id":athlete_id,          
        "name":name,
        "grade":grade,
        "major":major,
        "num":num
        }
        return HttpResponse(json.dumps(return_value))
        # return json.dumps(return_value)
    except Exception,ex:
        return HttpResponse(Exception)
        
@csrf_exempt    
def select_student_by_name(request):
    try:  
        return_value=[]
        name = request.POST['name']
        athlete_objects = Athlete.objects.all().get(name=name)
        for athlete_object in athlete_objects:
            class_id = athlete_objects.classObject.class_id
            class_object= Class.objects.all().get(class_id=class_id)
            athlete_id = athlete_object.athlete_id
            grade = class_object.grade
            major = class_object.major
            num = class_object.num
            student={"athlete_id":athlete_id,"name":name,"major":major,"grade":grade,"num":num}
            return_value.append(student)            
        return HttpResponse(json.dumps(return_value))
        # return json.dumps(return_value)
    except Exception,ex:
        return HttpResponse(Exception)
        
@csrf_exempt
def add_student(request):
    try:
        athlete_id = request.POST['athlete_id']
        name = request.POST['name']
        grade = request.POST['grade']
        major = request.POST['major']
        num = request.POST['num']
        print athlete_id
        print name
        print major
        print grade
        print num
        athlete_exist = len(Athlete.objects.all().filter(athlete_id=athlete_id))
        if athlete_exist == 1:
            return HttpResponse("已存在相同学号的记录")
        class_exit = len(Class.objects.all().filter(grade=grade,major=major,num=num))
        if class_exit == 1:
            class_object=Class.objects.all().get(grade=grade,major=major,num=num)
        else:
            Class.objects.create(grade=grade,major=major,num=num)
            class_object=Class.objects.all().get(grade=grade,major=major,num=num)
        Athlete.objects.create(athlete_id=athlete_id,name=name,classObject=class_object)
        athlete_object=Athlete.objects.all().get(athlete_id=athlete_id)
        class_object.save()
        athlete_object.save()
        return HttpResponse("添加成功")
    except Exception,ex:
        return HttpResponse(Exception)


@csrf_exempt
def del_student(request):
    try:
        athlete_id = request.POST['athlete_id']
        state = Athlete.objects.all().get(athlete_id=athlete_id).delete()
        return HttpResponse("已经成功删除") 
    except Exception,ex:
        return HttpResponse(Exception)

    
@csrf_exempt
def change_student(request):
    try:
        athlete_id_old=request.POST['athlete_id_old']
        athlete_id = request.POST['athlete_id']
        name = request.POST['name']
        grade = request.POST['grade']
        major = request.POST['major']
        num = request.POST['num']
        
        athlete_exist = len(Athlete.objects.all().filter(athlete_id=athlete_id))
        change_itself= (athlete_id==athlete_id_old)
        if athlete_exist == 1 and change_itself==False:
            return HttpResponse("已存在相同学号的记录")
        athlete_object = Athlete.objects.all().get(athlete_id=athlete_id_old)
        class_exit = len(Class.objects.all().filter(grade=grade,major=major,num=num))
        if class_exit == 1:
            class_object=Class.objects.all().get(grade=grade,major=major,num=num)
        else:
            Class.objects.create(grade=grade,major=major,num=num)
            class_object=Class.objects.all().get(grade=grade,major=major,num=num)
        athlete_object.athlete_id=athlete_id
        athlete_object.name = name
        athlete_object.classObject = class_object
        Athlete.objects.all().get(athlete_id=athlete_id_old).delete()
        class_object.save()
        athlete_object.save()
        return HttpResponse("修改成功") 
    except Exception,ex:
        return HttpResponse(Exception)