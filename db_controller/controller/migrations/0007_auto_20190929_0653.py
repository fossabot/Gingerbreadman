# Generated by Django 2.2.5 on 2019-09-29 06:53

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('controller', '0006_image_service_face_rect_analyzed'),
    ]

    operations = [
        migrations.RenameField(
            model_name='image',
            old_name='service_face_rect_analyzed',
            new_name='service_face_location_analyzed',
        ),
    ]
