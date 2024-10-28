extends Node

signal inventory_changed()
var items = []

func add_item(item: String):
	items.push_back(item)
	inventory_changed.emit()
