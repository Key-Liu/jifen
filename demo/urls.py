#! /usr/bin/env python
# -*- coding: utf-8 -*-

# URLconf
from django.conf.urls import patterns ,url ,include

from demo import views


# The url() function is passed four arguments, two required: regex and view, and two optional: kwargs, and name. 
# At this point, it’s worth reviewing what these arguments are for.

urlpatterns = patterns("",  # 来到polls的urls.py再分派,regex的前面已经有之前的参数了
 	# url(r'^show/$',views.ShowView.as_view(),name='show'),
 	# url(r'^show/(?P<pk>\d+)/$',views.DetailView.as_view(),name="detail"),
 	# url(r'^show/(?P<pk>\d+)/showtag/$',views.ShowtagView.as_view(),name="showtag"),
 	# url(r'^show/(?P<pk>\d+)/addtag/$',views.addtag,name="addtag"),
 	# url(r'^show/(?P<pk>\d+)/showcomment/$',views.ShowcommentView.as_view(),name="showcomment"),
 	# url(r'^show/(?P<pk>\d+)/addcomment/$',views.addcomment,name="addcomment"),
 	# url(r'^show/(?P<pk>\d+)/newcomment/$',views.newcomment,name="newcomment"),
 	# url(r'^ueditor/',include('DjangoUeditor.urls' )),
 	# url(r'^ueditor/$',views.get_editor,name="geteditor"),
 	# url(r'^show/$',views.ShowView.as_view(),name='show'),
 	url(r'^edit_sport/$',views.EditSportView.as_view(),name='edit_sport'),
 	url(r'^view_sport/$',views.view_sport,name="view_sport"),
 	url(r'^add_sport/$',views.add_sport,name="add_sport"),
 	url(r'^del_sport/$',views.del_sport,name="del_sport"),
 	url(r'^change_sport/$',views.change_sport,name="change_sport"),
	)


