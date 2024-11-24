extends RigidBody2D

func _ready():
	# Asegúrate de que la caja esté en el grupo "movable"
	add_to_group("movable")

#
#@onready var character_body_2d: Player = $"../CharacterBody2D"
#
#var push_force = 500  # Fuerza de empuje
#
## Método que se llama cuando un cuerpo entra en contacto con la caja
#func _on_body_entered(body):
	#if body == character_body_2d:  # Asegúrate de que tu personaje se llame "Player"
		## Aplica una fuerza en la dirección del jugador
		#var direction = (body.position - position).normalized()  # Dirección de empuje
		#apply_impulse(Vector2(), direction * push_force)  # Aplica la fuerza en la dirección del jugador
