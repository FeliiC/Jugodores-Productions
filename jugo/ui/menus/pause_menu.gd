extends CanvasLayer


@onready var back: Button = $VBoxContainer/BackToGame
@onready var restart: Button = $VBoxContainer/RestartGame
@onready var mainMenu: Button = $VBoxContainer/MainMenu
@onready var quit: Button = $VBoxContainer/Quit
@onready var audio: Button = $VBoxContainer/Audio
@onready var pause_menu: VBoxContainer = $VBoxContainer
@onready var menu_audio: Control = $Audio
@onready var back_pause_menu: Button = $Audio/HBoxContainer/Sliders/Back_Pause_Menu
@onready var music: HSlider = $Audio/HBoxContainer/Sliders/Music
@onready var sound: HSlider = $Audio/HBoxContainer/Sliders/Sound


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	back.pressed.connect(_on_back_pressed)
	restart.pressed.connect(_on_restart_pressed)
	mainMenu.pressed.connect(_on_mainMenu_pressed)
	quit.pressed.connect(_on_quit_pressed)
	audio.pressed.connect(_on_audio_pressed)
	back_pause_menu.pressed.connect(on_back_pause_menu_pressed)
	music.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	sound.value = db_to_linear(AudioServer.get_bus_volume_db(2))
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
	#get_tree().change_scene_to_file("res://main.tscn")
	InventoryManager.num = 0
	get_tree().reload_current_scene()
	
func _on_audio_pressed() -> void:
	pause_menu.hide()
	menu_audio.show()
	
func on_back_pause_menu_pressed() -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(music.value))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound"), linear_to_db(sound.value))
	pause_menu.show()
	menu_audio.hide()

	
func _on_mainMenu_pressed() -> void:
	get_tree().paused = false
	#get_tree().change_scene_to_packed(menu)
	Manager._go_to_menu()
	
func _on_quit_pressed() -> void:
	get_tree().paused = false
	get_tree().quit()
