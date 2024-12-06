extends Node2D


@onready var ui_inventory: CanvasLayer = $UIInventory
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	set_lastScene()
	if ui_inventory.keysNum >= 6:
		ui_inventory.keysNum = 0
		print("6 keys")
		get_tree().paused = true
		GameState.cave_level_unlocked = true
		GameState.oak_level_unlocked = true
		Manager._go_to_victory_menu()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_lastScene() -> void:
	InventoryManager.lastCheckpoint = "res://levels/oak_woods_level.tscn"
