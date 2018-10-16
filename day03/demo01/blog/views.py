from io import BytesIO
import logging


from django.shortcuts import render, redirect
from django.shortcuts import reverse
from django.http import HttpResponseRedirect, HttpResponse, JsonResponse
from django.core.cache import cache
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_POST #这个装饰器表示只支持post请求
# from django.views.decorators.http import require_http_methods #这个装饰器表示只支持post请求
from django.forms.models import model_to_dict
from django.core.serializers import serialize
from django.conf import settings
from django.core.paginator import Paginator


from . import models
from . import utils
from . import cacheUtils
from .utils import require_login


#首页函数
def index(request):
	logger = logging.getLogger("django")
	logger.warning("首页运行")
	articles = cacheUtils.get_all_article()
	users = models.User.objects.all()
		# print("数据库中查询到数据，同步到缓存")
		# cache.set("allArticle", articles)
	pageSize = int(request.GET.get("pageSize", settings.PAGE_SIZE))
	pageNow = int(request.GET.get("pageNow", 1))

	#分页器
	paginator = Paginator(articles, pageSize)
	page = paginator.page(pageNow)

	return render(request, "blog/index.html", {"page":page,"pageSize":pageSize, "users":users})


#增加用户函数
def add_user(request):
	return render(request, "blog/add_user.html", {})


#删除用户
@require_login
def delete_user(request, user_id):
	# u_id = request.GET["id"]
	user = models.User.objects.get(pk=user_id)
	user.delete()
	# return render(request, "blog/list_user.html", {})
	# return HttpResponseRedirect("/blog/list_user/")
	return redirect("/blog/list_user/")


#展示用户列表
def list_user(request):
	users = models.User.objects.all()
	return render(request, "blog/list_user.html", {"users":users})


#用户注册
def reg(request):
	if request.method == "GET":
		return render(request, "blog/add_user.html", {"msg":"请认真填写如下选项"})
	elif request.method == "POST":
		#接收参数
		try:
			username = request.POST["username"].strip()
			password = request.POST.get("password").strip()
			confirmpwd = request.POST.get("confirmpwd").strip()
			nickname = request.POST.get("nickname", None)

			#头像
			avatar = request.FILES.get("avatar", 'static/img/img/headers/5.jpg')

			# #验证码
			# code = request.POST["code"]
			#
			# #获取用户输入的验证码
			# mycode = request.session["code"]
			#
			# #删除session中的验证码
			# del request.session["code"]
			#
			# #数据校验
			# if code.upper() != mycode.upper():
			# 	return render(request, "blog/add_user.html", {"msg":"验证码输入错误,请重新输入!!"})
			if len(username) < 1:
				return render(request, "blog/add_user.html", {"msg":"用户账号不能为空！"})
			if len(password) < 6:
				return render(request, "blog/add_user.html", {"msg":"密码长度不能小于6位！"})
			if password != confirmpwd:
				return render(request, "blog/add_user.html", {"msg":"两次的密码不一致！"})
			#判断用户名是否已被注册
			try:
				user = models.User.objects.get(username=username)
				return render(request, "blog/add_user.html", {"msg": "该用户账号已经存在，请重新填写！！"})
			except:
				#加密
				password = utils.hmac_by_md5(password)

				# 保存数据
				user = models.User(username=username, password=password, nickname=nickname, header=avatar)
				user.save()
				return render(request, "blog/login.html", {"msg": "恭喜您，注册成功！！"})
		except Exception as e:
			print(e)
			return render(request, "blog/add_user.html", {"msg": "对不起，注册失败,请重新注册！！"})


		# 	#保存数据
		# 	user = models.User(username=username, password=password, nickname=nickname)
		# 	user.save()
		# 	return render(request, "blog/add_user.html", {"msg":"恭喜你， 注册成功"})
		# except Exception as e:
		# 	print(e)
		# 	return render(request, "blog/add_user.html", {"msg":"对不起，用户名称不能为空！"})


#展示单个用户
def show(request, u_id):
	user = models.User.objects.get(pk=u_id)
	# user = models.User.objects.filter(id=u_id)
	return render(request, "blog/show.html", {"user": user})


#修改用户信息
def update(request, u_id):
	if request.method == "GET":
		user = models.User.objects.filter(id=u_id).first()
		return render(request, "blog/update.html", {"user":user, "msg":"请认真填写如下内容"})
	else:
		nickname = request.POST["nickname"]
		age = request.POST["age"]

		# #数据校验
		# if age < 0:
		# 	return render(request, "blog/update.html", {"msg": "好好在娘胎里待着，不要作妖"})
		# if age > 100:
		# 	return render(request, "blog/update.html", {"msg": "年龄太大就安静一点吧"})

		#修改数据
		#获取用户
		user = models.User.objects.get(pk=u_id)
		#修改数值
		user.age = age
		user.nickname = nickname
		#保存
		user.save()

		return redirect("/blog/show/" + str(u_id) + "/")
		# return redirect("/blog/show", args(u_id, ))
		# return redirect(reverse("blog:show",args=(u_id,)))


#修改密码
def update_password(request):
	user = request.session["loginUser"]
	if request.method == "GET":
		# user = models.User.objects.filter(id=u_id).first()
		return render(request, "blog/update_password.html", {"user":user, "msg":"请认真填写如下内容"})
	else:
		password = request.POST.get("password").strip()
		password = utils.hmac_by_md5(password)
		newpassword = request.POST.get("newpassword").strip()
		newpassword = utils.hmac_by_md5(newpassword)
		confirmpwd = request.POST.get("confirmpwd").strip()
		confirmpwd = utils.hmac_by_md5(confirmpwd)


		#修改密码，获取用户
		# user = models.User.objects.get(pk=u_id)
		# user = request.session["loginUser"]
		#获取旧密码
		password = user.password
		#修改密码
		# 数据校验
		if password != password:
			return render(request, "blog/update_password.html", {"msg": "原密码输入错误"})
		# if newpassword < 6:
		# 	return render(request, "blog/update_password.html", {"msg": "密码必须是6位以上"})
		if newpassword != confirmpwd:
			return render(request, "blog/update_password.html", {"msg": "两次密码不一致"})

		try:
			user.password = newpassword
			newpassword = utils.hmac_by_md5(newpassword)
			#保存数据
			user.save()

			#返回界面
			# return redirect("/blog/show/" + str(u_id) + "/")
			return render(request, "blog/login.html", {"msg": "密码修改成功"})
		except:
			return render(request, "blog/update_password.html", {"msg": "密码修改失败"})


#修改用户头像
# (用户头像需要登陆后才会发生变化，原因是头像是存在session中，不是数据库中，所以重新登录session才会变化）
def update_header(request):
	u_id = request.session['loginUser'].id
	user = models.User.objects.get(pk=u_id)
	# user = request.session['loginUser']
	if request.method == "GET":
		return render(request, "blog/update_header.html", {"user":user})
	else:
		header = request.FILES.get("avatar")

		try:
			#修改数值
			user.header = header
			#保存

			user.save()
			# delete.sess["header"]
			cacheUtils.get_all_article(ischanage=True)


			# return redirect("/blog/show/" + str(u_id) + "/")
			return redirect(reverse("blog:index"))
		except Exception as e:
			print(e,'11111111111111111111111111111111111')
			# return redirect(reverse("blog:index"))


#用户登陆函数
def login(request):
	if request.method == "GET":
		return render(request, "blog/login.html", {"msg":"欢迎登录"})
	elif request.method == "POST":
		username = request.POST["username"]
		password = request.POST["password"]

		try:
			# # 验证码
			# code = request.POST["code"]
			#
			# # 获取用户输入的验证码
			# mycode = request.session["code"]
			#
			# # 删除session中的验证码
			# del request.session["code"]
			#
			# # 数据校验
			# if code.upper() != mycode.upper():
			# 	return render(request, "blog/login.html", {"msg": "验证码输入错误,请重新输入!!"})

			password = utils.hmac_by_md5(password)
			user = models.User.objects.get(username=username, password=password)
			request.session["loginUser"] = user
			#使用cookie记住用户密码
			response = redirect(reverse("blog:index"))
			response.set_cookie("password", user.password, max_age=3600 * 24 * 7 )#max_age代表失效时间
			return response

			# return redirect(reverse("blog:index"))
		except:
			return render(request, "blog/login.html", {"msg":"登录失败，请检查你的账号密码"})


#用户退出
def logout(request):
	try:
		del request.session["loginUser"]
	finally:
		return redirect(reverse("blog:index"))


##################################################################################


#增加文章
def add_article(request):
	if request.method == "GET":
		return render(request, "blog/add_article.html", {"msg":"开始编写你的文章吧"})
	else:
		title = request.POST["title"]
		content = request.POST["content"]
		author = request.session["loginUser"]

		#数据校验
		if title is None:
			return render(request, "blog/update.html", {"msg": "标题输入错误"})
		# if age > 100:
		# 	return render(request, "blog/update.html", {"msg": "年龄太大就安静一点吧"})

		article = models.Article(title=title, content=content, author=author)
		article.save()

		#将缓存重新更新
		cacheUtils.get_all_article(ischanage = True)

		# return redirect(reverse("blog:show_article", kwargs={"a_id": article.id}))
		return JsonResponse({"msg":"文章添加成功", "success":True})


#删除文章
def delete_article(request, a_id):
	article = models.Article.objects.get(pk=a_id)
	article.delete()

	# 将缓存重新更新
	cacheUtils.get_all_article(ischanage=True)

	return redirect(reverse("blog:index"))


#修改文章
def update_article(request, a_id):
	article = models.Article.objects.get(pk=a_id)
	if request.method == "GET":
		return render(request, "blog/update_article.html", {"article":article})
	else:
		title = request.POST["title"]
		content = request.POST["content"]
		article.title = title
		article.content = content
		article.save()
		return redirect(reverse("blog:show_article", kwargs={"a_id":a_id}))


#展示单篇文章
def show_article(request, a_id):
	article = models.Article.objects.get(pk=a_id)
	return render(request, "blog/show_article.html", {"article":article})


#展示当前用户所有的文章
def show_all_article(request):
	# articles = models.Article.objects.all()
	# try:
	articles = models.Article.objects.filter(author = request.session["loginUser"].id)
	return render(request, "blog/show_all_article.html", {"articles": articles})
	# except:
	# 	return redirect(reverse("blog:login"))


############################################################################################
#验证码函数
def code(request):
	img, code = utils.create_code()
	#首先需要将code保存到session中
	request.session['code'] = code
	#返回图片
	file = BytesIO()
	img.save(file, "PNG")

	return HttpResponse(file.getvalue(), "image/png")


#@csrf_exempt表示装饰者的函数忽略csrf验证
@require_POST
# @require_http_methods("GET", "POST")
# @csrf_exempt
def ajax_hello(request):
	id = request.POST["id"]
	# username = request.POST["username"]
	# print(id, username)
	article = models.Article.objects.get(pk=id)
	# msg = {
	# 	"id":user.id,
	# 	"uusername":user.username,
	# 	"unickname":user.nickname,
	# 	"uage":user.age,
	# }
	# return HttpResponse("HELLO,WORLD!!!")
	#返回的是字符串
	# return HttpResponse(msg)
	#返回的一个字符串，自动变更为字典
	# return JsonResponse(model_to_dict(article))

	ats = models.Article.objects.all()
	return HttpResponse(serialize("json", ats))


#注册的Ajax函数
def checkusername(request, username):
	qs = models.User.objects.filter(username=username)
	if len(qs) > 0:
		return JsonResponse({"msg":"该用户账号已被注册，请重新输入", "success":False})
	else:
		return JsonResponse({"msg":"账号可用", "success":True})