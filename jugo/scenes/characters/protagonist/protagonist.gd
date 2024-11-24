class_name Player
extends CharacterBody2D


#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0

@export var speed = 400
@export var jump_speed = 750
@export var gravity = 2000
@export var acceleration = 2000
@export var attacking = false
@onready var pivot: Node2D = $Pivot
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")

@onready var ui_inventory: CanvasLayer = $"../UIInventory"
@onready var jump_sound: AudioStreamPlayer2D = $Jump_sound
@onready var kill_enemy_sound: AudioStreamPlayer = $Kill_enemy_sound

@onready var detect_box: RayCast2D = $Pivot/DetectBox



func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	var move_input = Input.get_axis("move_left", "move_right")
	if attacking:
		move_input = 0
	velocity.x = move_toward(velocity.x, speed *  move_input, acceleration * delta)
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -jump_speed
		jump_sound.play()
	move_and_slide()
	
	if move_input != 0:
		pivot.scale.x = sign(move_input)
	
	#if ui_inventory.keysNum >= 3:
		##InventoryManager.num = 0
		#get_tree().paused = true
		#Manager._go_to_victory_menu()
		
	
	if is_on_floor():
		if abs(velocity.x) > 10 or move_input:
			playback.travel("run")
		else:
			playback.travel("idle")
	else:
		if velocity.y < 0:
			playback.travel("jump")
		else:
			playback.travel("fall")
			
	
	if detect_box.is_colliding():
		print("veo una cajita")
		var collider = detect_box.get_collider()
		if collider.is_in_group("pusheable"):
			print("empujo cajita")
			#collider.direction = 1*sign(move_input)
			var direction = global_position.direction_to(collider.global_position).normalized()
			#collider.velocity += direction * 500
			collider.velocity = collider.velocity.lerp(direction * 1000, 0.1)
			collider.move_and_slide()
			



func pickup(item: String):
	print("Item!!")
	InventoryManager.add_item(item)

#func _physics_process(delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
	#
	#
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = -jump_speed
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * speed
	#else:
		#velocity.x = move_toward(velocity.x, 0, speed)
#
	#move_and_slide()


func take_damage(damage: int):
	InventoryManager.num = 0
	queue_free()
	get_tree().paused = true
	Manager._go_to_failed_menu()
	
	
