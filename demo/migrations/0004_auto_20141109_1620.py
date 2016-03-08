# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('demo', '0003_auto_20141109_1616'),
    ]

    operations = [
        migrations.AlterField(
            model_name='score',
            name='ext_mark',
            field=models.IntegerField(help_text=b'\xe7\xa0\xb4\xe6\xa0\xa1\xe3\x80\x81\xe9\x99\xa2\xe8\xae\xb0\xe5\xbd\x95\xe9\xa2\x9d\xe5\xa4\x96\xe5\x8a\xa0\xe5\x88\x86\xe6\x83\x85\xe5\x86\xb5', null=True),
        ),
    ]
