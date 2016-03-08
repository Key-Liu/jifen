from django import template
register = template.Library()
@register.filter(name='cut_result')
def cut_result(value,arg):
	return value[int(arg):int(arg)+2]

