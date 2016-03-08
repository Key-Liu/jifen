# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('demo', '0002_auto_20141108_1836'),
    ]

    operations = [
        migrations.AlterField(
            model_name='score',
            name='ext_mark',
            field=models.IntegerField(default=0, help_text=b'\xe7\xa0\xb4\xe6\xa0\xa1\xe3\x80\x81\xe9\x99\xa2\xe8\xae\xb0\xe5\xbd\x95\xe9\xa2\x9d\xe5\xa4\x96\xe5\x8a\xa0\xe5\x88\x86\xe6\x83\x85\xe5\x86\xb5'),
        ),
        migrations.AlterField(
            model_name='score',
            name='score_id',
            field=models.AutoField(default=1, serialize=False, primary_key=True),
        ),
        migrations.AlterField(
            model_name='sport',
            name='sport_id',
            field=models.IntegerField(default=1, help_text=b'\xe8\xbf\x90\xe5\x8a\xa8\xe9\xa1\xb9\xe7\x9b\xae ID', serialize=False, primary_key=True),
        ),
    ]
