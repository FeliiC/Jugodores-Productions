extends CharacterBody2D

var gravity = 1500
var jump_speed = -1000
var jumping = false
var is_dead = false
#@onready var detection_area: Area2D = $DetectionArea
var time_between_jumps = 1
var jump_timer = 0.0

func _ready():
	jump_timer = time_between_jumps

func _physics_process(delta):
	velocity.y += gravity * delta

	if is_on_floor():
		jumping = false
		jump_timer -= delta
		if jump_timer <= 0.0:
			jump()
			jump_timer = time_between_jumps
	move_and_slide()

func jump():
	velocity.y = jump_speed
	jumping = true

func _on_body_entered(body: Node):
	if body.name == "Player":
		die()

func take_damage(damage: int):
	queue_free()
	
func die():
	if not is_dead:
		is_dead = true
		queue_free()
