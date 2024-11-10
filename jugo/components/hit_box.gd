class_name Hitbox
extends Area2D

signal damage_dealt()
@onready var kill_enemy_sound: AudioStreamPlayer = $"../Kill_enemy_sound"

@export var damage: int = 10
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
