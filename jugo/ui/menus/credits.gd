
extends Control
@onready var rich_text_label: RichTextLabel = $RichTextLabel
@onready var button: Button = $Button

# Called when the node enters the scene tree for the first time.
 

func _ready() -> void:
	await get_tree().create_timer(3).timeout
	button.pressed.connect(Manager._go_to_menu)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rich_text_label.get_v_scroll_bar().value += delta * 10
	
	
	
