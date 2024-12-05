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


@onready var tilemap : TileMapLayer = get_parent().get_node("TileMapLayerInteractive")

@onready var esta_enganchado = false

@onready var cerca_de_cuerda = false

func _ready():
	# Deferimos la conexión para asegurar que los nodos existen
	call_deferred("_setup_connections")
	
func _setup_connections():
	$"Area2D".connect("body_entered", Callable(self, "_on_area_2d_body_entered"))
	$"Area2D".connect("body_exited", Callable(self, "_on_area_2d_body_exited"))

func _on_area_2d_body_entered(body):
	print("hola")
	if body == tilemap:
		print("hola2")
		#var tile_position = tilemap.local_to_map(position)
		#var tile_id = tilemap.get_cell_source_id(Vector2i(tile_position.x, tile_position.y))
#
		#if tile_id != -1:
			#print("estoy cerca de una cuerda")
			## Obtener los datos del tile usando get_cell_tile_data()
			#var tile_data = tilemap.get_cell_tile_data(Vector2i(tile_position.x, tile_position.y))  # Capa 0 y coordenada de la celda
			#
			#if tile_data:
				#print("hola")
				#var tile_name = tile_data.get_custom_data("tileName")
				#if tile_name == "rope" and not esta_enganchado:
					#enganchado_a_cuerda()
		#enganchado_a_cuerda()
		cerca_de_cuerda = true
		
func _on_area_2d_body_exited(body):
	cerca_de_cuerda = false
	esta_enganchado = false
	

func _physics_process(delta: float) -> void:
	if not is_on_floor() and esta_enganchado == false:
		velocity.y += gravity * delta
	var move_input = Input.get_axis("move_left", "move_right")
	if attacking:
		move_input = 0
	velocity.x = move_toward(velocity.x, speed *  move_input, acceleration * delta)
	
	if cerca_de_cuerda == true and esta_enganchado == false:
		#print("¡vamo a engancharno!")
		if Input.is_action_just_pressed("rope"):
			velocity.y = 0
			esta_enganchado = true
			print(esta_enganchado)
			# Aquí va la lógica para engancharse (por ejemplo, el jugador no puede moverse, se mueve con la cuerda, etc.)
			print("¡Jugador enganchado a la cuerda!")
			#velocity.y = 0
			
	if cerca_de_cuerda == false:
		esta_enganchado = false
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -jump_speed
		jump_sound.play()
	#move_and_slide()
	
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
			
			
			
	if tilemap == null:
		print("No hay cuerdas.")
		return
		
		
		
	#check_for_rope_collision()
	## Convertir la posición del jugador al sistema de coordenadas del TileMap
	#var tile_position = tilemap.local_to_map(position)
	#var tile_id = tilemap.get_cell_source_id(Vector2i(tile_position.x, tile_position.y))
#
	#if tile_id != -1:
		#print("estoy cerca de una cuerda")
		## Obtener los datos del tile usando get_cell_tile_data()
		#var tile_data = tilemap.get_cell_tile_data(Vector2i(tile_position.x, tile_position.y))  # Capa 0 y coordenada de la celda
		#
		#if tile_data:
			#print("hola")
			#var tile_name = tile_data.get_custom_data("tileName")
			#if tile_name == "rope" and not esta_enganchado:
				#enganchado_a_cuerda()
	if esta_enganchado == true and Input.is_action_just_pressed("jump"):
		esta_enganchado = false
		cerca_de_cuerda = false
		
	move_and_slide()

#func check_for_rope_collision():
	## Obtener información de las colisiones activas
	#for i in range(get_slide_collision_count()):
		#var collision = get_slide_collision(i)
		#if is_rope_tile(collision.get_position()):
			#print("hola2")
			#if not esta_enganchado:
				#enganchado_a_cuerda()
				#break
			
#func is_rope_tile(position):
	##print("hola")
	## Convertir la posición de colisión a coordenadas del TileMap
	#var tile_position = tilemap.local_to_map(position)
	#var tile_id = tilemap.get_cell_source_id(Vector2i(tile_position.x, tile_position.y))
	#print("colisioné")
	#if tile_id != -1:  # Verificar que el tile es válido
		#print("hola")
		#var tile_data = tilemap.get_cell_tile_data(Vector2i(tile_position.x, tile_position.y))
		#if tile_data:
			#var tile_name = tile_data.get_custom_data("tileName")
			#return tile_name == "rope"
	#return false


#func enganchado_a_cuerda():
	#print("¡vamo a engancharno!")
	#if Input.is_action_just_pressed("rope"):
		#velocity.y = 0
		#esta_enganchado = true
		#print(esta_enganchado)
		## Aquí va la lógica para engancharse (por ejemplo, el jugador no puede moverse, se mueve con la cuerda, etc.)
		#print("¡Jugador enganchado a la cuerda!")
		#velocity.y = 0
	## Si está enganchado, solo permitimos movimiento horizontal
	
	#direccion.x = 0  # Reseteamos cualquier movimiento horizontal previo
	#
	## Mover a la izquierda
	#if Input.is_action_pressed("move_left"):
		#direccion.x = -1
	## Mover a la derecha
	#elif Input.is_action_pressed("move_right"):
		#direccion.x = 1
	#
	## Aplicamos el movimiento horizontal
	#move_and_slide()

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
	
	
#func on_area_entered(lever: Area2D) -> void:
	#lever.turn_level(1)
	#Input.is_action_pressed("lever")


#func _on_area_2d_body_entered(body: Node2D) -> void:
	#pass # Replace with function body.
