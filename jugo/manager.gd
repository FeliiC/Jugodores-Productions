extends Node

@export var mainMenuScene: PackedScene
@export var creditsScene: PackedScene
@export var failedMenuScene: PackedScene
@export var victoryMenuScene: PackedScene
@export var sampleScene: PackedScene
@export var tutorialScene: PackedScene
@export var CWBScene: PackedScene
@export var CaveScene: PackedScene
@export var num: int = 0
@export var playerInvoke = false
@export var playerInRange = false
# Called when the node enters the scene tree for the first time.
@export var levels: Array[LevelInfo]
var levels_data = [
	{
		"level": "tutorial",
		"locked": false
	},
	{
		"level": "sample",
		"locked": true
	}
]

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

func _go_to_tutorial_level() -> void:
	if not tutorialScene:
		return
	get_tree().change_scene_to_packed(tutorialScene)

func _go_to_cwb_level() -> void:
	if not CWBScene:
		return
	get_tree().change_scene_to_packed(CWBScene)

func _go_to_cave_level() -> void:
	if not CaveScene:
		return
	get_tree().change_scene_to_packed(CaveScene)

func save_game() -> void:
	var data = JSON.stringify(
		[
			{
				"level": "tutorial",
				"locked": false
			},
			{
				"level": "sample",
				"locked": true
			}
		]
	)
	var file = FileAccess.open_encrypted_with_pass("user://level.data", FileAccess.WRITE, "1234")
	file.store_string(data)
	file.close()


func load_game() -> void:
	var file = FileAccess.open_encrypted_with_pass("user://level.data", FileAccess.READ, "1234")
	var dict = JSON.parse_string(file.get_as_text())
	levels_data = dict
