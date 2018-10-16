# from django.contrib import admin
import xadmin
from xadmin import views

from . import models
# Register your models here.

class UserAdmin(object):

	#列表时显示的属性
	list_display = ["username", "nickname", "age"]

	#列表时过滤的字段
	list_filter = ("age",)


class BaseSetting(object):
	enable_themes = True
	use_bootswatch = True


class GlobalSettings(object):
	site_title = "博客管理系统后台"
	site_footer = "2018@qikuedu.com"
	menu_style = "accordion"


xadmin.site.register(models.User,UserAdmin)
xadmin.site.register(models.Article)
xadmin.site.register(views.BaseAdminView, BaseSetting)
xadmin.site.register(views.CommAdminView,GlobalSettings)