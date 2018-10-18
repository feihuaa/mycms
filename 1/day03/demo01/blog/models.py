from django.db import models
# from tinymce.models import HTMLField
from DjangoUeditor.models import UEditorField


#与用户相关的路由
class User(models.Model):
	id = models.AutoField(primary_key=True)
	username = models.CharField(max_length=50, unique="True", verbose_name="用户账号")
	password = models.CharField(max_length=255, verbose_name="用户密码")
	nickname = models.CharField(max_length=255, null=True, blank=True, verbose_name="用户昵称")
	age = models.IntegerField(default=18, verbose_name="用户年龄")
	# birthday = models.DateTimeField(auto_now_add=True, default="2000-10-10 00:00:00", verbose_name="出生日期")
	# header = models.CharField(max_length=255, default="/static/blog/img/headers/4.jpg", verbose_name="用户头像")
	# hesder = models.FileField()
	header = models.ImageField(upload_to='static/img/img/headers/', default="static/img/img/headers/5.jpg", verbose_name="用户头像")

	#将用户按照注册时间进行排列
	class Meta:
		ordering = ["id"]

	def __str__(self):
		return self.nickname


#与文章相关的路由
class Article(models.Model):
	id = models.AutoField(primary_key=True)
	title = models.CharField(max_length=255, verbose_name="文章标题")
	# content = models.TextField(verbose_name="文章内容")
	# content = HTMLField(verbose_name="文章内容")
	content = UEditorField(verbose_name="文章内容")
	publishTime = models.DateField(auto_now_add=True)
	modifyTime = models.DateField(auto_now=True)

	#外键
	#一对一
	# author = models.OneToOneField
	#一对多
	author = models.ForeignKey(User, on_delete=models.CASCADE)
	#多对多
	# author = models.ManyToManyField

	#将文章按照发布时间的倒序进行排列
	class Meta:
		ordering = ["-publishTime"]