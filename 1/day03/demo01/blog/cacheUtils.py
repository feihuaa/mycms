"""
关于redis缓存的函数
"""
#引入需要的函数
from django.core.cache import cache

from . import models


#缓存首页所有数据内容
def get_all_article(ischanage=False):
	print("首页开始查询数据")
	articles = cache.get("allArticle")
	if articles is None or ischanage:
		print("缓存中没有数据，开始查询数据")
		articles = models.Article.objects.all()
		# users = models.User.objects.all()
		print("数据库中查询到数据，同步到缓存")
		cache.set("allArticle", articles)
	return articles