# All children must run successfully
class_name BTSequence extends BeeTreeNode

var current_child:int = 0

func run():
	super.run()
	
	var child = get_child(current_child)
	child.run()
	if child.status == STATUS.SUCCESS:
		next()
		running()
	elif child.status == STATUS.FAILURE:
		current_child = 0
		failure()
	else:
		running()

func next():
	current_child += 1
	if current_child >= get_child_count():
		current_child = 0
		success()
