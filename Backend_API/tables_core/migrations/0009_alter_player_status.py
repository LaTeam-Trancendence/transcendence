# Generated by Django 5.1.3 on 2024-12-08 10:33

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('tables_core', '0008_match_duration_alter_customuser_image'),
    ]

    operations = [
        migrations.AlterField(
            model_name='player',
            name='status',
            field=models.CharField(default='online'),
        ),
    ]
