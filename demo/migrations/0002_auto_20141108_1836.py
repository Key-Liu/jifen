# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('demo', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='score',
            name='score_id',
            field=models.AutoField(serialize=False, primary_key=True),
        ),
        migrations.AlterField(
            model_name='sport',
            name='sport_id',
            field=models.AutoField(help_text=b'\xe8\xbf\x90\xe5\x8a\xa8\xe9\xa1\xb9\xe7\x9b\xae ID', serialize=False, primary_key=True),
        ),
        migrations.AlterUniqueTogether(
            name='score',
            unique_together=set([('sportObject', 'classObject', 'athleteObject', 'final')]),
        ),
    ]
