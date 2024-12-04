extends Area2D

# Señal para detectar cuando el personaje entra
signal character_entered

signal lever_left

signal lever_right


const TEXTURES : Dictionary = {
	"right" : preload("res://assets/interactive/tile_0066.png"),
	"left" : preload("res://assets/interactive/tile_0064.png")
}



#@export var link_code : int = 3



@onready var inside : int = 0

@onready var facing: int = -1

#@onready var actionables_container: Node2D = owner.get_node("Actionables")
@onready var sprite : Sprite2D = get_node("Sprite2D")

@onready var platform : Node2D = get_parent().get_node("PlatformCB")


func _ready() -> void:
	add_to_group("levers")
	print("Palanca añadida al grupo levers")
	
# Cuando un cuerpo entra en el área
func _on_Area2D_body_entered(body):
	if body is Player:  # Verifica si el cuerpo es una instancia de Player
		print("El personaje está dentro del área")
		#sprite.texture = TEXTURES.right
		#print("activar palanca")
		inside = 1
		emit_signal("character_entered")  # Emite la señal

# Cuando un cuerpo sale del área
func _on_Area2D_body_exited(body):
	if body is Player:
		inside = 0
		print("El personaje ha salido del área")
		
		
		
# Función que se llama en cada frame
func _process(delta):
	change()  # Llamamos a la función que verifica la acción

func change() :
	if inside == 1:
		if Input.is_action_just_pressed("lever"):
			print("activar palanca")
			facing  = !facing
			#print("vamoss")
			if facing == 1:
				sprite.texture = TEXTURES.right
				emit_signal("lever_right")
			else:
				sprite.texture = TEXTURES.left
				emit_signal("lever_left")
		
	#if platform.link_code == link_code:
		#connect("lever_right", Callable(platform, "_on_lever_right"))


#
#
## Variable para almacenar si la palanca está activada
#var is_activated = false
#
## Referencia a la plataforma que será controlada
#@onready var platform = $"../PlatformCB"
#@onready var lever_sprite = $Sprite2D
#
#func _ready():
	## Asegúrate de que la palanca empieza en su estado inicial
	#update_lever_visual()
#
#func _on_area_input_event(viewport, event, shape_idx):
	#print("estoy en el area")
	#if event.is_action_pressed("lever"):  # Cambia "ui_accept" por la tecla de interacción
		#print("muevo palanca")
		#is_activated = !is_activated
		#update_lever_visual()
		#print("actualizo visual")
		#platform.move_platform(is_activated)
		#print("actualizo visual")
#
#func update_lever_visual():
	#if is_activated:
		#lever_sprite.texture = load("res://assets/interactive/tile_0066.png")
	#else:
		#lever_sprite.texture = load("res://assets/interactive/tile_0064.png")
#
#
#@export var link_code : int = 0
#
#signal activated()
#
#const TEXTURES : Dictionary = {
	#"right" : preload("res://assets/interactive/tile_0066.png"),
	#"left" : preload("res://assets/interactive/tile_0064.png")
#}
#
## Indica si se gira hacia la derecha o lz izquierda.
#var facing : int = 1
#
##@onready var actionables_container: Node2D = owner.get_node("Actionables")
#@onready var sprite : Sprite2D = get_node("Sprite2D")
##
#func _ready() -> void:
	#if link_code != 0:
		#for actionable in actionables_container.get_children():
			#if actionable.link_code == link_code:
				#connect("activated", Callable(actionable, "_change_state"))
				#
#
#func turn_lever(direction: int) -> void:
	#if facing == direction:
		#return
		#
	#facing = direction
	#emit_signal("activated")
	#if facing == 1:
		#sprite.texture = TEXTURES.right
	#else:
		#sprite.texture = TEXTURES.left
