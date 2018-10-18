from django.contrib import admin

from . import models
# Register your models here.

class UserAdmin(admin.ModelAdmin):

	#列表时显示的属性
	list_display = ["username", "nickname", "age"]

	#列表时过滤的字段
	list_filter = ("age",)


admin.site.register(models.User,UserAdmin)
admin.site.register(models.Article)
