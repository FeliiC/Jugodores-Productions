extends Node

@export var mainMenuScene: PackedScene
@export var creditsScene: PackedScene
@export var failedMenuScene: PackedScene
@export var victoryMenuScene: PackedScene
@export var sampleScene: PackedScene
@export var num: int = 0
@export var playerInvoke = false
@export var playerInRange = false
# Called when the node enters the scene tree for the first time.
@export var levels: Array[LevelInfo]

func _go_to_menu() -> void:
	if not mainMenuScene:
		return
	get_tree().change_scene_to_packed(mainMenuScene)
	
func _go_to_credits() -> void:
	if not creditsScene:
		return
	get_tree().change_scene_to_packed(creditsScene)
	
func _go_to_failed_menu() -> void:
	if not failedMenuScene:
		return
	get_tree().change_scene_to_packed(failedMenuScene)

func _go_to_victory_menu() -> void:
	if not victoryMenuScene:
		return
	get_tree().change_scene_to_packed(victoryMenuScene)
	
#func _go_to_main() -> void:
func _go_to_sample_level() -> void:
	if not sampleScene:
		return
	get_tree().change_scene_to_packed(sampleScene)
