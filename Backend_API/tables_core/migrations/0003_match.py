# Generated by Django 5.1.3 on 2024-11-26 17:09

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('tables_core', '0002_alter_customuser_groups_and_more'),
    ]

    operations = [
        migrations.CreateModel(
            name='Match',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('user_score', models.IntegerField(default=0)),
                ('adv_score', models.IntegerField(default=0)),
                ('result', models.IntegerField(default=0)),
                ('date', models.DateTimeField(null=True)),
                ('start_match', models.DateTimeField(null=True)),
                ('end_match', models.DateTimeField(null=True)),
                ('adv', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='adv_matches', to='tables_core.player')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='user_matches', to='tables_core.player')),
            ],
        ),
    ]
