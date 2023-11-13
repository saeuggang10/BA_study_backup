# Generated by Django 4.0.1 on 2023-07-13 08:22

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('oracleapp', '0003_lprod_prod'),
    ]

    operations = [
        migrations.CreateModel(
            name='CartMember',
            fields=[
                ('cart_no', models.CharField(max_length=13, primary_key=True, serialize=False)),
                ('cart_prod', models.CharField(max_length=10)),
                ('cart_qty', models.IntegerField()),
            ],
            options={
                'db_table': 'cart',
                'managed': False,
            },
        ),
    ]
