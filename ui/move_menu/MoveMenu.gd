extends ScrollContainer

signal use_move(move_name)

onready var vbox : VBoxContainer = $VBoxContainer
onready var font : DynamicFont = preload("res://assets/fonts/Kenney Space 12.tres")


func _ready():
	add_move(moves.MoveSet["Puke"])
	add_move(moves.MoveSet["Puke"])
	add_move(moves.MoveSet["Puke"])


func add_move(move : moves.Move) -> void:
	var button = Button.new()
	button.text = move.name
	button.flat = true
	button.add_font_override("font", font)
	vbox.add_child(button)
	button.connect("pressed", self, "_move_pressed", [button])


func _move_pressed(button):
	emit_signal("use_move", button.text)
