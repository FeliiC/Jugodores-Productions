extends HBoxContainer
#representacion abstracta de un item 

@onready var label: Label = $Label

func setup(item :String, num: int):
	label.text = str(num)
