# -*- coding: utf-8 -*-

from django.conf.urls import patterns ,url ,include
from student import views

urlpatterns = patterns("",  
     url(r'^edit_student/$',views.EditStudentView.as_view(),name='edit_student'),
     #url(r'^edit_student/$',views.edit_student,name='edit_student'),
     url(r'^view_student/$',views.view_student,name='view_student'),
     url(r'^select_student_by_athlete_id/$',views.select_student_by_athlete_id,name="select_student_by_athlete_id"),
     url(r'^add_student/$',views.add_student,name="add_student"),
     url(r'^del_student/$',views.del_student,name="del_student"),
     url(r'^change_student/$',views.change_student,name="change_student"),
     url(r'^search_student/$',views.search_student,name="search_student"),
    )
