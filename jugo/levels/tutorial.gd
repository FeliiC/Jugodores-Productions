extends Node2D

@onready var ui_inventory: CanvasLayer = $UIInventory
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	set_lastScene()
	if ui_inventory.keysNum >= 3:
		ui_inventory.keysNum = 0
		print("3 keys")
		get_tree().paused = true
		Manager._go_to_menu()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_lastScene() -> void:
	InventoryManager.lastCheckpoint = "res://levels/tutorial.tscn"
