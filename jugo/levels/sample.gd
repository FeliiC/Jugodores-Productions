class_name Game
extends Node2D

@onready var spawnPoint: Marker2D = $spawnPoint
@onready var last_checkpoint: Vector2
@onready var ui_inventory: CanvasLayer = $UIInventory

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	set_lastScene()
	if ui_inventory.keysNum >= 3:
		ui_inventory.keysNum = 0
		print("3 keys")
		get_tree().paused = true
		Manager._go_to_victory_menu()
		


#func _on_body_entered(body: Node) -> void:
	#if not spawnPoint:
		#return
	#var player = body as Player
	#if player:
		#action()


func set_lastScene() -> void:
	InventoryManager.lastCheckpoint = "res://levels/Sample.tscn"
