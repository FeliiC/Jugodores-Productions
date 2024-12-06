class_name Quest
extends Resource

@export var title: String
@export var description: String
var completed: bool = false

func run(player:Player) -> void:
	pass
func check_completed(player: Player) -> bool:
	return completed
