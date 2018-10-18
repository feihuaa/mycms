from django.shortcuts import render


#首页函数
def index(request):
	# articles = models.Article.objects.all()
	return render(request, "blog/index.html", {})