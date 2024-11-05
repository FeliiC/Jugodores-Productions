class_name KillZone

extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node) -> void:
	var player = body as Player
	if player:
		player.take_damage(1)

func _process(delta):
	pass
