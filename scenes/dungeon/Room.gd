extends Node2D

signal room_pressed(path)

export(Array, NodePath) var next_rooms

onready var texture : TextureRect = $Texture

var active : bool = false setget set_active


func _ready():
	update()


func _draw():
	for next_room_path in next_rooms:
		var next_room : Node2D = get_node(next_room_path)
		if active:
			draw_line(Vector2(), next_room.global_position - global_position,
				Color.yellow, 7, true)
		else:
			draw_line(Vector2(), next_room.global_position - global_position,
				Color.gray, 3, true)


func _on_Texture_mouse_entered():
	texture.rect_scale = Vector2(1.2, 1.2)


func _on_Texture_mouse_exited():
	texture.rect_scale = Vector2(1, 1)


func set_active(toggle : bool) -> void:
	active = toggle
	if active:
		texture.modulate = Color(2, 2, 2)
	else:
		texture.modulate = Color(1, 1, 1)
	update()


func _on_Texture_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("room_pressed", get_path())
