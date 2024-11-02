extends CanvasLayer

@onready var restart: Button = $VBoxContainer/Restart
@onready var menu: Button = $VBoxContainer/Menu



func _ready() -> void:
	restart.pressed.connect(_on_restart_pressed)
	menu.pressed.connect(_on_mainMenu_pressed)
	
func _on_restart_pressed() -> void:
	get_tree().paused = false
	#get_tree().change_scene_to_file("res://main.tscn")
	get_tree().reload_current_scene()
	
	
func _on_mainMenu_pressed() -> void:
	get_tree().paused = false
	#get_tree().change_scene_to_packed(menu)
	Manager._go_to_menu()
