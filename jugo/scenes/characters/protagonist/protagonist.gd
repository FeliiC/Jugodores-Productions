class_name Player
extends CharacterBody2D


#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0

@export var speed = 400
@export var jump_speed = 750
@export var gravity = 2000
@export var acceleration = 2000
@export var attacking = false

@export var push_force = 100  # Fuerza de empuje para la caja
@export var is_pushing_box = false  # Para saber si el jugador está empujando la caja
@export var move_force = 10.0

@onready var pivot: Node2D = $Pivot
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")

@onready var ui_inventory: CanvasLayer = $"../UIInventory"
@onready var jump_sound: AudioStreamPlayer2D = $Jump_sound
@onready var kill_enemy_sound: AudioStreamPlayer = $Kill_enemy_sound



func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	var move_input = Input.get_axis("move_left", "move_right")
	if attacking:
		move_input = 0
	velocity.x = move_toward(velocity.x, speed *  move_input, acceleration * delta)
	
	
	
	#for i in get_slide_collision_count():
		#var collision = get_slide_collision(i)
		#var rigidbody = collision.get_collider() as CharacterBody2D
		#if rigidbody and rigidbody is Box:
			#var direction = global_position.direction_to(rigidbody.global_position).normalized()
			##rigidbody.apply_impulse(direction * 10000 )
			##rigidbody.position += direction * push_force * delta
			#rigidbody.velocity = direction * push_force
			##velocity += -direction * 500
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -jump_speed
		jump_sound.play()
	move_and_slide()
	
	## Verificar si el jugador está empujando la caja
	#for i in get_slide_collision_count():
		#var collision = get_slide_collision(i)
		#var rigidbody = collision.get_collider() as RigidBody2D
		#if rigidbody:
				## Verificar si el jugador está cerca de la caja y empujarla
				#var direction_to_box = global_position.direction_to(rigidbody.global_position).normalized()
				#
				## Si el jugador está empujando la caja
				#if !is_pushing_box:
						#is_pushing_box = true
						#rigidbody.sleeping = false  # Cambiar la caja a KINEMATIC para controlarla manualmente
#
				## Aplica impulso a la caja
				#rigidbody.apply_impulse(direction_to_box * push_force)
		#else:
				#if is_pushing_box and rigidbody:
						#is_pushing_box = false
						#rigidbody.sleeping = true  # Volver a la física normal cuando ya no se empuja

	
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
	
	
	
func _ready():
	# Conectar la señal `body_entered` al método que manejará la colisión
	connect("body_entered", self, "_on_body_entered")
	
# Función que se llama cuando el cuerpo entra en contacto con otro cuerpo
func _on_body_entered(body):
	# Verificamos si la colisión es con un objeto que sea una caja (o cualquier otro objeto con un nombre o etiqueta específico)
	if body.is_in_group("movable"):  # Asegúrate de que la caja con la que colisionas esté en este grupo
		# Mover la caja en la dirección deseada, por ejemplo, hacia adelante
		var direction = (body.global_transform.origin - global_transform.origin).normalized()
		body.linear_velocity = direction * move_force  # Usamos la dirección de la colisión y le damos una velocidad
		
