class_name BeeTree extends Node

signal running(node)
signal failure(node)
signal success(node)

signal node_run(node)

@export var ticks_per_second = 10.0

@export var autostart:bool = false

var timer:Timer

var current_node:BeeTreeNode:
	get:
		return current_node
	set(node):
		current_node = node
		emit_signal('node_run', node)

@export var agentNode:NodePath

@export var blackboard := {}

var agent

func _ready():
	if agentNode:
		agent = get_node(agentNode)
	
	timer = Timer.new()
	timer.wait_time = 1.0 / ticks_per_second
	timer.one_shot = false
	timer.timeout.connect(tick)
	add_child(timer)
	
	if autostart:
		start()

func start():
	timer.start()
	_call_children_recursively(get_child(0))

func _call_children_recursively(node):
	node.start(self)
	for child in node.get_children():
		_call_children_recursively(child)

func pause():
	timer.set_paused(true)

func resume():
	timer.set_paused(false)

func stop():
	timer.stop()

func tick():
	if not is_instance_valid(agent):
		timer.stop()
		return
	
	var node = get_child(0)
	if node:
		node.run()
