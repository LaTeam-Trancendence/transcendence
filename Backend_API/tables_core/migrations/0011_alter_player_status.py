# Generated by Django 5.1.3 on 2024-12-08 14:30

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('tables_core', '0010_alter_customuser_image'),
    ]

    operations = [
        migrations.AlterField(
            model_name='player',
            name='status',
            field=models.CharField(blank=True, max_length=20),
        ),
    ]
