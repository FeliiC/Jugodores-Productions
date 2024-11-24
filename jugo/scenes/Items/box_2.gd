extends CharacterBody2D

var push_force = 300  # Fuerza con la que la caja se moverá
var is_pushed = false  # Para verificar si la caja está siendo empujada
var last_velocity = Vector2.ZERO  # La última velocidad de la caja

func _physics_process(delta):
	var player = null  # Referencia al jugador
	
	# Revisar las colisiones con el jugador
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

		if collider and collider is CharacterBody2D:  # Asegurarnos de que es el jugador
			player = collider
			break  # Solo necesitamos la primera colisión, ya que el jugador es un solo objeto
	
	# Si el jugador está cerca de la caja y empujándola
	if player:
		var direction_to_player = global_position.direction_to(player.global_position).normalized()
		
		# La caja se moverá en dirección del jugador
		velocity = direction_to_player * push_force  # Establecemos la velocidad de la caja

		# Evitar que la caja gire (si no queremos que gire)
		#angular_velocity = 0
		
		# Marcar que la caja está siendo empujada
		is_pushed = true
	else:
		# Si el jugador no está cerca, la caja se detiene
		if is_pushed:
			is_pushed = false
			velocity = Vector2.ZERO  # Detener la caja cuando ya no se la empuja
			#angular_velocity = 0  # Evitar que siga girando
	move_and_slide()
