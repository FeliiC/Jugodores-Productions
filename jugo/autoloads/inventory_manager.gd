extends Node

signal inventory_changed()
var items = []
var lastCheckpoint

@onready var num: int = 0


@onready var numu: int = 0
func add_item(item: String):
	items.push_back(item)
	inventory_changed.emit()
	
