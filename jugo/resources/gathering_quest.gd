class_name GatheringQuest
extends Quest

@export var thing: String 
@export var quantity: int 

func run(player: Player) -> void:
	pass

func check_completed(player: Player) -> bool:
	var count = player.ui_inventory.
	return completed
