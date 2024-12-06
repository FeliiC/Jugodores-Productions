extends Control


## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
#@onready var start: Button = %Start
@onready var credits: Button = %Credits
@onready var quit: Button = %Quit
@onready var sample: Button = %Sample
@onready var levels = %Levels
@onready var tutorial = %Tutorial
@onready var unresolved_level = $VBoxContainer/UnresolvedLevel
@onready var cave_level = %CaveLevel
@onready var cwb_level = %CWBLevel


#var main = preload("res://main.tscn")  #方法1
@export var main: PackedScene


func _ready() -> void:
	sample.visible = GameState.sample_unlocked
	cave_level.visible = GameState.cave_level_unlocked
	cwb_level.visible = GameState.cwb_unlocked
	#start.pressed.connect(_on_start_pressed)
	credits.pressed.connect(_on_credits_pressed)
	tutorial.pressed.connect(_on_tutorial_pressed)
	sample.pressed.connect(_on_sample_pressed)
	quit.pressed.connect(_on_quit_pressed)            #←
	#quit.pressed.connect(func(): get_tree().quit())  #效果同上
	#quit.pressed.connect(get_tree().quit）        #效果同上
	levels.pressed.connect(func(): get_tree().change_scene_to_file("res://ui/menus/levels_menu.tscn"))
	unresolved_level.pressed.connect(_on_new_tutorial_pressed)
	cave_level.pressed.connect(_on_cave_level_pressed)
func _on_start_pressed() -> void:
	get_tree().change_scene_to_packed(main)
	#get_tree().change_scene_to_file("res://main.tscn") #方法3(与方法1，方法2的缺点一样，
	#get_tree().change_scene_to_packed(main)  #方法1           就是一旦目标位置变了就无法
	#或者在函数里（方法2）：                                      正确运行。)
	#var main_path = "res://main.tscn"
	#var main = load(main_path)
	#get_tree().change_scene_to_packed(main)
	
	
func _on_credits_pressed() -> void:
	#get_tree().change_scene_to_file("res://credits.tscn")
	Manager._go_to_credits()
	
	
	#Manager._go_to_credits()
	
	
func _on_quit_pressed() -> void:
	get_tree().quit()
	

func _on_sample_pressed() -> void:
	Manager._go_to_sample_level()

func _on_new_tutorial_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/NewTutorial.tscn")

func _on_tutorial_pressed() -> void:
	Manager._go_to_tutorial_level()

func _on_cave_level_pressed() -> void:
	Manager._go_to_cave_level()
