extends Control

@export var ui_level_scene: PackedScene
@onready var ui_level_container = $VBoxContainer/UILevelContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	if not ui_level_scene:
		return
	for level_info in Manager.levels:
		var ui_level_inst = ui_level_scene.instantiate()
		ui_level_container.add_child(ui_level_inst)
		ui_level_inst.setup(level_info, false)
