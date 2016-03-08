#! /usr/bin/env python
# -*- coding: utf-8 -*-

# URLconf
from django.conf.urls import patterns, url
from loggrade import views

urlpatterns = patterns('',
	url(r'^view/$',views.LogGradeView.as_view(),name='view'),
	url(r'^view_sport/$',views.view_sport,name='view_sport'),
	url(r'^login_preliminary/(?P<sport_id>\d+)/(?P<group>\d+)/$',views.login_preliminary,name='login_preliminary'),
	url(r'^login_score/$',views.login_score,name='login_score'),
	url(r'^login_final/(?P<sport_id>\d+)/(?P<group>\d+)/$',views.login_final,name='login_final'),
	url(r'^new_score/$',views.new_score,name='new_score'),
	url(r'^change_score/$',views.change_score,name='change_score'),
	url(r'^check_final/(?P<sport_id>\d+)/$',views.check_final,name='check_final'),
	url(r'^cal_final/(?P<sport_id>\d+)/$',views.cal_final,name='cal_final'),
	url(r'^delete_score/$',views.delete_score,name='delete_score'),
	# url(r'^process_grade/$',views.process_grade,name='process_grade'),(刘璟)
	)