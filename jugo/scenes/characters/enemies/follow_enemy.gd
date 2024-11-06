extends CharacterBody2D

@export var wait_to_jump = false
@export var speed = 110.0
@export var gravity = 500
@export var jump_velocity = -300.0
@export var acceleration = 2000

var target: Player
@onready var detection_area: Area2D = $DetectionArea
@onready var pivot: Node2D = $Pivot
@onready var ray_cast: RayCast2D = $Pivot/RayCast2D
@onready var jump_cooldown: Timer = $JumpCooldown

func _ready() -> void:
	detection_area.body_entered.connect(_on_detection_body_entered)
	detection_area.body_exited.connect(_on_detection_body_exited)
	

func _physics_process(delta: float) -> void:
	if not target:
		var direction = pivot.scale.x
		velocity.x = move_toward(velocity.x, direction * speed, acceleration * delta)
	else:	
		var direction = global_position.direction_to(target.global_position)
		velocity.x = move_toward(velocity.x, direction.x * speed, acceleration * delta)
		if direction.y < 0:
			_jump()
	# Add the gravity.
	if is_on_floor() and not ray_cast.is_colliding():
		pivot.scale.x *= -1
		
	
	if not is_on_floor():
		velocity.y += gravity * delta

	move_and_slide()


func _on_detection_body_entered(body: Node) -> void:
	var player = body as Player
	if player:
		target = player
		

func _on_detection_body_exited(body: Node) -> void:
	if body == target:
		target = null

func _jump() -> void:
	if is_on_floor():
		velocity.y = jump_velocity
		

func take_damage(damage: int):
	queue_free()
