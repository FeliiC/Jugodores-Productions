extends CanvasLayer
@onready var character_body_2d: Player = $"../CharacterBody2D"
@onready var texto_1: Label = $VBoxContainer/texto1
@onready var texto_4: Label = $VBoxContainer/texto4


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		texto_1.add_theme_color_override("font_color", Color(0,1,0))
	if Input.is_action_just_pressed("jump"):
		texto_4.add_theme_color_override("font_color", Color(0,1,0))
		
		 
		
		
		
	pass
