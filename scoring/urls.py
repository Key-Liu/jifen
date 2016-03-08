from django.conf.urls import patterns, include, url
from django.contrib import admin

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'scoring.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),
    # app URL
    url(r'^admin/', include(admin.site.urls)),
    url(r'^demo/', include('demo.urls',namespace="demo")),
    url(r'^student/', include('student.urls',namespace="student")),
    url(r'^athlete/',include('athlete.urls',namespace='athlete')),
    url(r'^loggrade/',include('loggrade.urls',namespace="loggrade")),
    url(r'^rank/',include('rank.urls',namespace="rank")),
    url(r'^',include('classmanage.urls',namespace="class")),
)
