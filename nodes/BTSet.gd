class_name BTSet extends BeeTreeNode

enum TYPE {
	INT,
	FLOAT,
	STRING,
	VECTOR2,
	BOOL
}

@export var property:String
@export var type:TYPE
@export var value:String = ""

func get_value():
	return str_to_var(value)

func run():
	super.run()
	
	var val = get_value()
	
	tree.agent.set(property, val)
	success()
