#! /usr/bin/env python
# -*- coding: utf-8 -*-

from django.shortcuts import render
from django.views import generic
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
from demo.models import *
import json
# Create your views here.

def class_l(request):
	latest_sport_list = Sport.objects.order_by('-sport_id')
	context = {
		'latest_sport_list':latest_sport_list,
	}
	return render(request,'manage/class.html',context)