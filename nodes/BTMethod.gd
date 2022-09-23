class_name BTMethod extends BeeTreeNode

enum MODE {
	ALWAYS_SUCCEED,
	SUCCEED_WHEN_METHOD_TRUE
}

@export var method:String
@export var mode:MODE = MODE.ALWAYS_SUCCEED

func run():
	super.run()
	
	var result = tree.agent.call(method)
	if mode == MODE.ALWAYS_SUCCEED:
		success()
	elif result:
		success()
	else:
		failure()
