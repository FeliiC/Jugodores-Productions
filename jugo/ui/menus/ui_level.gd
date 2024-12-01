extends Button

@onready var name_label = $NameLabel
@onready var locked_texture = $LockedTexture

var _level_info: LevelInfo

func _ready() -> void:
	pressed.connect(_on_pressed)

func setup(level_info: LevelInfo, locked: bool) -> void:
	name_label.text = level_info.display_name
	locked_texture.visible = locked

func _on_pressed() -> void:
	get_tree().change_scene_to_packed(_level_info.scene)
