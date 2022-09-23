class_name BeeTreeNode extends Node

enum STATUS {
	FRESH,
	RUNNING,
	SUCCESS,
	FAILURE
}

var status:STATUS = STATUS.FRESH

var tree:BeeTree
var parent

func start(tree:BeeTree):
	self.tree = tree
	parent = get_parent()

func run():
	tree.current_node = self

func running() -> void:
	status = STATUS.RUNNING
	tree.emit_signal("running", self)

func failure() -> void:
	status = STATUS.FAILURE
	tree.emit_signal("failure", self)

func success() -> void:
	status = STATUS.SUCCESS
	tree.emit_signal("success", self)
