from django.conf.urls import patterns ,url

from athlete import views

urlpatterns = patterns('',
	url(r'^$',views.athleteview,name="athlete"),
	url(r'^view_sport/$',views.view_sport,name="view_sport"),
	url(r'^(?P<sport_id>\d+)$',views.athletedetail,name="athlete_detail"),
	url(r'^default/$',views.athletedefault,name="athlete_default"),
	url(r'^change_athlete/$',views.change_athlete,name="change_athlete"),
	url(r'^delete_athlete/$',views.delete_athlete,name="delete_athlete"),
	url(r'^add_page/(?P<sport_id>\d+)$',views.addpage,name="add_page"),
	url(r'^get_athlete/$',views.get_athlete,name="get_athlete"),
	url(r'^add_athlete/$',views.add_athlete,name="add_athlete"),
)