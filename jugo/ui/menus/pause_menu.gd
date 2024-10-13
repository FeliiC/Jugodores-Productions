extends CanvasLayer


@onready var back: Button = $VBoxContainer/BackToGame
@onready var restart: Button = $VBoxContainer/RestartGame
@onready var mainMenu: Button = $VBoxContainer/MainMenu
@onready var quit: Button = $VBoxContainer/Quit


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	back.pressed.connect(_on_back_pressed)
	restart.pressed.connect(_on_restart_pressed)
	mainMenu.pressed.connect(_on_mainMenu_pressed)
	quit.pressed.connect(_on_quit_pressed)
	hide()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		visible = not visible
		get_tree().paused = visible


func _on_back_pressed() -> void:
	hide()
	get_tree().paused = false

func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main.tscn")
	
	
func _on_mainMenu_pressed() -> void:
	get_tree().paused = false
	#get_tree().change_scene_to_packed(menu)
	Manager._go_to_menu()
	
func _on_quit_pressed() -> void:
	get_tree().paused = false
	get_tree().quit()
