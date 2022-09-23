# Run through children
# fails if all children fail
# succeeds if ANY child succeeds
class_name BTSelector extends BeeTreeNode

var current_child:int = 0

func run():
	super.run()
	
	var child = get_child(current_child)
	child.run()
	
	if child.status == STATUS.SUCCESS:
		current_child = 0
		success()
	elif child.status == STATUS.FAILURE:
		next()
		running()
	else:
		running()

func next():
	current_child += 1
	if current_child >= get_child_count():
		current_child = 0
