from django.conf.urls import patterns ,url

from rank import views

urlpatterns = patterns('',
	url(r'^$',views.rank,name="rank"),
	url(r'^sport/$',views.rank_sport,name="rank_sport"),
	url(r'^class/$',views.rank_class,name="rank_class"),
	url(r'^sport/(?P<sport_id>\d+)$',views.rank_sport_detail,name="rank_sport_detail"),
	url(r'^sport/default/$',views.rank_sport_default,name="rank_sport_default"),
	url(r'^class/compute/$',views.rank_class_compute,name="rank_class_compute"),
	url(r'^class/datail/$',views.rank_class_detail,name="rank_class_detail"),
	url(r'^class/default/$',views.rank_class_default,name="rank_class_default"),
	# url(r'^class/view/$',views.rank_class_csv,name="rank_class_csv"),
	# url(r'^sport/rank/(?P<sport_id>\d+)$',views.rank_sport_csv,name="rank_sport_csv"),
	url(r'^export/sport/$',views.export_sport,name="export_sport"),
	url(r'^export/class/$',views.export_class,name="export_class"),
)