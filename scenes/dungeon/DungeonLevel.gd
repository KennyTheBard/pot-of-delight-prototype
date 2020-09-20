extends Node2D

export(NodePath) var entrance_room_path

var current_room_path : NodePath
var rooms : Array = []

func _ready():
	# find rooms
	for child in get_children():
		if child is Node2D:
			rooms.append(child)
			child.connect("room_pressed", self, "_on_Room_room_pressed")
	
	# set current room
	update_current_room(entrance_room_path)


func update_current_room(room_path):
	# mark previous room as inactive
	if not current_room_path.is_empty():
		get_node(current_room_path).set_active(false)
	# update current room
	get_node(room_path).set_active(true)
	current_room_path = room_path


func _on_Room_room_pressed(path):
	var current_room : Node2D = get_node(current_room_path)
	for next_path in current_room.next_rooms:
		if get_node(path) == current_room.get_node(next_path):
			update_current_room(path)
