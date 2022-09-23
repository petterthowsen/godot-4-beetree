# run the child and return its success if a condition is true
# otherwise, return failure
class_name BTIF extends BeeTreeNode

enum TYPE {
	BLACKBOARD,
	AGENT
}

enum OPERATOR {
	EQUALS,
	NOT_EQUALS,
	NOT_NULL,
	IS_TRUE,
	IS_FALSE,
	GREATER_THAN,
	GREATER_OR_EQUALS,
	LESS_THAN,
	LESS_OR_EQUALS,
}

@export var type:TYPE = TYPE.AGENT
@export var method:String = ""
@export var property:String = ""
@export var operator:OPERATOR = OPERATOR.EQUALS
@export var value:String = ""

func _check():
	var v
	
	if type == TYPE.AGENT:
		if not is_instance_valid(tree.agent):
			return false
		
		if method != "":
			v = tree.agent.call(method)
		else:
			v = tree.agent.get(property)	
	else:
		if tree.blackboard.has(property):
			v = tree.blackboard[property]
		else:
			v = null
	
	
	match operator:
		OPERATOR.EQUALS:
			if v is String:
				return v == value
			elif v is Array:
				return v.size() == value
			else:
				return str_to_var(v) == str_to_var(value)
		OPERATOR.NOT_EQUALS:
			if v is String:
				return v != value
			elif v is Array:
				return v.size() != str_to_var(value)
			else:
				return str_to_var(v) != str_to_var(value)
		OPERATOR.GREATER_THAN:
			if v is String:
				return v.length() > str_to_var(value)
			elif v is Array:
				return v.size() > str_to_var(value)
			else:
				return v > value
		OPERATOR.GREATER_OR_EQUALS:
			if v is String:
				return v.length() >= str_to_var(value)
			elif v is Array:
				return v.size() >= str_to_var(value)
			else:
				return v > value
		OPERATOR.LESS_THAN:
			if v is String:
				return v.length() < str_to_var(value)
			elif v is Array:
				return v.size() < str_to_var(value)
			else:
				return v < str_to_var(value)
		OPERATOR.LESS_OR_EQUALS:
			if v is String:
				return v.length() <= str_to_var(value)
			elif v is Array:
				return v.size() <= str_to_var(value)
			else:
				return v <= str_to_var(value)
		OPERATOR.NOT_NULL:
			return v != null
		OPERATOR.IS_TRUE:
			return v == true
		OPERATOR.IS_FALSE:
			return v == false
			

func run():
	super.run()
	
	if _check():
		if get_child_count() == 0:
			failure()
		else:
			var child = get_child(0)
			child.run()
			if child.status == STATUS.SUCCESS:
				success()
			elif child.status == STATUS.FAILURE:
				failure()
			else:
				running()
	else:
		failure()
