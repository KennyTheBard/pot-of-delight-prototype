extends ScrollContainer

signal use_move(move_name)

onready var vbox : VBoxContainer = $VBoxContainer
onready var font : DynamicFont = preload("res://assets/fonts/Kenney Space 12.tres")


func add_move(move : moves.Move) -> void:
	var button = Button.new()
	button.text = move.name
	button.align = Button.ALIGN_LEFT
	button.flat = true
	button.add_font_override("font", font)
	vbox.add_child(button)
	button.connect("pressed", self, "_move_pressed", [button])


func _move_pressed(button):
	emit_signal("use_move", button.text)


func disable_buttons(state : bool):
	for button in vbox.get_children():
		button.disabled = state
