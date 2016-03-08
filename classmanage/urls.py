from django.conf.urls import patterns ,url

from classmanage import views

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'scoring.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),

   url(r'^$',views.class_l,name="class_l"),
)