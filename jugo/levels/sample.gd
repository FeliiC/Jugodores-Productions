class_name Game
extends Node2D

@onready var spawnPoint: Marker2D = $spawnPoint
@onready var last_checkpoint: Vector2

func _ready() -> void:
	pass


#func _on_body_entered(body: Node) -> void:
	#if not spawnPoint:
		#return
	#var player = body as Player
	#if player:
		#action()
