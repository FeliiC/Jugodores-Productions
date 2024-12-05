### Código para la plataforma (Plataforma.gd)
extends CharacterBody2D
#
##@onready var lever : Area2D = get_parent().get_node("Lever")  # Asegúrate de usar la ruta correcta a la palanca
#
#@export var link_code : int = 3
#
##func _ready():
	### Conectar las señales
	##lever.connect("lever_right", self, "_on_lever_right")  # Conectar la señal 'lever_right' al método '_on_lever_right'
	##lever.connect("lever_left", self, "_on_lever_left")  # Conectar la señal 'lever_left' al método '_on_lever_left'
#
## Métodos para reaccionar a las señales
#func _on_lever_right():
	#print("La palanca se ha movido a la derecha")
#
#func _on_lever_left():
	#print("La palanca se ha movido a la izquierda")



@export var speed : float = 100.0  # Velocidad de movimiento de la plataforma
@export var leverName : String
@onready var lever : Node2D = get_parent().get_node(leverName)

@export var leverName2 : String
@onready var lever2 : Node2D

var moving_right : bool = false  # Indica si la plataforma se mueve a la derecha
var moving_left : bool = false   # Indica si la plataforma se mueve a la izquierda

func _ready():
	if has_node(leverName2):
		lever2 = get_node(leverName2)
	elif get_parent().has_node(leverName2):
		lever2 = get_parent().get_node(leverName2)
	# Deferimos la conexión para asegurar que los nodos existen
	call_deferred("_setup_connections")

#func _ready():
	## Nos aseguramos de que la plataforma siga el estado de la palanca cuando comience el juego
	#lever.connect("lever_right",Callable(self, "_on_lever_right"))
	#lever.connect("lever_left",Callable(self, "_on_lever_left"))
	#lever2.connect("lever_right",Callable(self, "_on_lever_right"))
	#lever2.connect("lever_left",Callable(self, "_on_lever_left"))
	
	
func _setup_connections():
	if lever and lever.has_method("connect"):
		lever.connect("lever_right", Callable(self, "_on_lever_right"))
		lever.connect("lever_left", Callable(self, "_on_lever_left"))
	else:
		print("Error: La palanca 'lever' no está disponible.")
	
	if lever2 and lever2.has_method("connect"):
		lever2.connect("lever_right", Callable(self, "_on_lever_right"))
		lever2.connect("lever_left", Callable(self, "_on_lever_left"))
	else:
		print("Error: La palanca 'lever2' no está disponible.")

func _on_lever_right():
	moving_right = true
	moving_left = false
	
func _on_lever_left():
	moving_left = true
	moving_right = false

#func _on_lever_activated():
	## Cuando la palanca se activa, moveremos la plataforma según la dirección de la palanca
	#if lever.facing == 1:
		#moving_right = true
		#moving_left = false
	#elif lever.facing == 0:
		#moving_left = true
		#moving_right = false

func _process(delta):
	# Mover la plataforma a la derecha o a la izquierda según el estado de los booleanos
	if moving_right:
		# Movimiento hacia la derecha
		velocity.x = speed
	elif moving_left:
		# Movimiento hacia la izquierda
		velocity.x = -speed
	else:
		velocity.x = 0  # Detenerse si no hay dirección

	# Aplicar la velocidad a la plataforma (Movimiento con colisiones)
	move_and_slide()



#extends CharacterBody2D
#
#@export var start_position: Vector2
#@export var end_position: Vector2
#@export var move_speed: float = 100.0
#var moving_to_end: bool = true
#
#func _ready():
	## Inicializa la posición
	#position = start_position
#
#func _physics_process(delta):
	## Calcula la posición objetivo dependiendo de la dirección actual
	#var target_position = end_position if moving_to_end else start_position
	#
	## Calcula la dirección hacia el objetivo
	#var direction = (target_position - position).normalized()
	#
	## Calcula el movimiento
	#var motion = direction * move_speed
	#
	## Establece la velocidad para mover la plataforma
	#velocity = motion
	#
	## Mueve la plataforma con colisiones
	#move_and_slide()
#
	## Cambia de dirección si la plataforma alcanza el objetivo
	#if position.distance_to(target_position) < 1:
		#moving_to_end = !moving_to_end
