extends Area2D

@export var display_name = "Item"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(on_body_entered) #si es que entró un body, entonces, con connect ejecutaremos una función


func on_body_entered(body: Node) -> void:
	var player = body as Player #as castea si corresponde a un player, si no, null
	if player: #si en efecto entr+o un player...
		#AudioManager.something
		player.pickup(display_name) #player se da cuenta de que lo tomó y ve cuál item es
		queue_free() #desaparece el item del mundo (ahora estará en el inventario)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
