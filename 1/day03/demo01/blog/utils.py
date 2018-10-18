"""
公共函数
这是验证码生成函数文件
"""
import random,string
import hashlib
import hmac
import logging
from PIL import Image,ImageDraw,ImageFont,ImageFilter

from django.conf import settings
from django.shortcuts import render


#一个判断用户是否登录的装饰器
def require_login(fn):
	def inner(request, *args, **kwargs):
		if request.session.has_key("loginUser"):
			logging.warning("用户已经登录，程序正常运行")
			return fn(request, *args, **kwargs)
		else:
			logging.warning("该操作必须登陆之后才能进行操作")
			return render(request, "blog/login.html", {"msg":"当前操作需要登录"})
	return inner


# 获取一个随机字符串，4位的
def getRandomChar(count=4):
    # 生成随机字符串
    # string模块包含各种字符串，以下为小写字母加数字
    ran = string.ascii_lowercase + string.ascii_uppercase + string.digits
    char = ''
    for i in range(count):
        char += random.choice(ran)
    return char


# 返回一个随机的RGB颜色
def getRandomColor():
    return (random.randint(50,150),random.randint(50,150),random.randint(50,150))


def create_code():
    # 创建图片，模式，大小，背景色
    img = Image.new('RGB', (120,30), (255,255,255))
    #创建画布
    draw = ImageDraw.Draw(img)
    # 设置字体
    font = ImageFont.truetype('comic.ttf', 25)

    code = getRandomChar()
    # 将生成的字符画在画布上
    for t in range(4):
        draw.text((30*t+5,0),code[t],getRandomColor(),font)

    # 生成干扰点
    for _ in range(random.randint(0,200)):
        # 位置，颜色
        draw.point((random.randint(0, 120),
		random.randint(0, 30)),
		fill=getRandomColor())

    # 使用模糊滤镜使图片模糊
    img = img.filter(ImageFilter.BLUR)
    # 保存
    # img.save(''.join(code)+'.jpg','jpeg')
    return img,code


##########################################################################################


#密码加密函数
def hash_by_md5(pwd):
	md5 = hashlib.md5(pwd.encede("utf-8"))
	md5.update(settings.MD5_SALT.encode("utf-8"))
	return md5.hexdigest()


#django的加密函数
def hmac_by_md5(pwd):
	return hmac.new(pwd.encode('utf-8'), settings.MD5_SALT.encode('utf-8'), "MD5").hexdigest()