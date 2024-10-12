extends Control


## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
@onready var start: Button = %Start
@onready var credits: Button = %Credits
@onready var quit: Button = %Quit

#var main = preload("res://main.tscn")  #方法1
@export var main: PackedScene


func _ready() -> void:
	start.pressed.connect(_on_start_pressed)
	#credits.pressed.connect(_on_credits_pressed)
	
	quit.pressed.connect(_on_quit_pressed)            #←
	#quit.pressed.connect(func(): get_tree().quit())  #效果同上
	#quit.pressed.connect(get_tree().quit）        #效果同上

func _on_start_pressed() -> void:
	get_tree().change_scene_to_packed(main)
	#get_tree().change_scene_to_file("res://main.tscn") #方法3(与方法1，方法2的缺点一样，
	#get_tree().change_scene_to_packed(main)  #方法1           就是一旦目标位置变了就无法
	#或者在函数里（方法2）：                                      正确运行。)
	#var main_path = "res://main.tscn"
	#var main = load(main_path)
	#get_tree().change_scene_to_packed(main)
	
	
#func _on_credits_pressed() -> void:
	#get_tree().change_scene_to_file("res://credits.tscn")
	
	
	#Manager._go_to_credits()
	
	
func _on_quit_pressed() -> void:
	get_tree().quit()