extends CanvasLayer
#es un canvas layer para que quede pegado a la cámara y no se mueva junto al persoaje

@onready var item_container: VBoxContainer = %ItemContainer

@export var ui_item_scene : PackedScene

var keysNum : int = 0

signal keys_full() #señal que se emite cuando ya se consiguieron todas las llaves del nivel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	InventoryManager.inventory_changed.connect(on_inventory_changed)


func on_inventory_changed():
	_clear_inventory()
	keysNum = keysNum+1
	var i
	for item in InventoryManager.items:
		i = item
	_add_item(i)
		
		
func _clear_inventory():
	for child in item_container.get_children():
		item_container.remove_child(child)
		child.queue_free()
	

func _add_item(item: String):
	if not ui_item_scene: #se nos olvdió poner la escena
		return
	var ui_item_inst=ui_item_scene.instantiate() #crea una instancia de un item en el inventario
	item_container.add_child(ui_item_inst) #vuando ya está listo lo agregamos al display del inventario
	ui_item_inst.setup(item, keysNum) #setup se encarga de armar el item. Debe ir después de insertarlo en el mundo (con addChild) o es nulo
	
	
	
func victory(nombre_item: String) -> void:
	if keysNum == 2: #2 por ahora
		emit_signal("keys_full")
