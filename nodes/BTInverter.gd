class_name BTInverter extends BeeTreeNode

func run():
	super.run()
	if get_child_count() == 0:
		success()
	else:
		var s = get_child(0).run()
		if s == STATUS.SUCCESS:
			failure()
		elif s == STATUS.FAILURE:
			success()
		else:
			running()
