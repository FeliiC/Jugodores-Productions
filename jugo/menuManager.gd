extends Node

@export var mainMenuScene: PackedScene
@export var creditsScene: PackedScene
@export var num: int = 0
# Called when the node enters the scene tree for the first time.


func _go_to_menu() -> void:
	if not mainMenuScene:
		return
	get_tree().change_scene_to_packed(mainMenuScene)
	
func _go_to_credits() -> void:
	if not creditsScene:
		return
	get_tree().change_scene_to_packed(creditsScene)
