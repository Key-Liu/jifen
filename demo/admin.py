from django.contrib import admin

# Register your models here.
from demo.models import *

admin.site.register(Class)
admin.site.register(Sport)
admin.site.register(Athlete)
admin.site.register(Score)
admin.site.register(Key)