extends CharacterBody2D

@export var wait_to_jump = false
@export var speed = 200.0
@export var gravity = 1300
@export var jump_velocity = -550.0
@export var acceleration = 2000
@export var pickable_item: PackedScene = null

var jumpTimeReseter: int = 3
var timer = 3

var target: Player
@onready var detection_area: Area2D = $DetectionArea
@onready var pivot: Node2D = $Pivot
@onready var ray_cast: RayCast2D = $Pivot/RayCast2D
@onready var jump_cooldown: Timer = $JumpCooldown
@onready var kill_enemy_sound: AudioStreamPlayer = $Kill_enemy_sound


func _ready() -> void:
	detection_area.body_entered.connect(_on_detection_body_entered)
	detection_area.body_exited.connect(_on_detection_body_exited)
	

func _physics_process(delta: float) -> void:
	#if not target:
		#var direction = pivot.scale.x
		#velocity.x = move_toward(velocity.x, direction * speed, acceleration * delta)
	#else:	
		#var direction = global_position.direction_to(target.global_position)
		#velocity.x = move_toward(velocity.x, direction.x * speed, acceleration * delta)
	## Add the gravity.
	#
	#if ray_cast.is_colliding():
		#var collider = ray_cast.get_collider()
		#if collider:
			#pivot.scale.x *= -1 
	
	#if is_on_floor():
		#if timer <= 0:
			#velocity.y = jump_velocity
			#timer = jumpTimeReseter
		#if not ray_cast.is_colliding():
			#pivot.scale.x *= -1	
	#
	if not is_on_floor():
		velocity.y += gravity * delta
	
	
	#timer -= 0.03
	
	
	
	#print(wait_to_jump)
	#_jump()
	#if wait_to_jump:
		#return 
	move_and_slide()
	



func _on_detection_body_entered(body: Node) -> void:
	var player = body as Player
	if player:
		target = player
		

func _on_detection_body_exited(body: Node) -> void:
	if body == target:
		target = null

#func _jump() -> void:
	#
	#if jump_cooldown.time_left:
		##print(jump_cooldown.time_left)
		#pass
	#else:
		#wait_to_jump = true
		#print(wait_to_jump)
		#if (is_on_floor()):
		##if (is_on_floor() and jump_cooldown.timeout):
			#print("jump")
			#velocity.y = jump_velocity
		#return
		#

func take_damage(damage: int):
	kill_enemy_sound.play()
	if pickable_item:
		var item_instance = pickable_item.instantiate()
		item_instance.global_position = global_position
		get_tree().current_scene.add_child(item_instance)
	queue_free()