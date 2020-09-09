extends Control


onready var vbox = $VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Enemy_use_move(move_name : String, move_color : String, damage, damage_type : String):
	var log_line = RichTextLabel.new()
	log_line.bbcode_enabled = true
	
	var move : String = "[color=" + move_color + "]" + move_name.to_upper() + "[/color]"
	var type : String = "[color=" + move_color + "]" + damage_type.to_upper() + "[/color]"
	log_line.bbcode_text = "Enemy used " + move + " for " + str(damage) + " " + type + " damage."
	log_line.rect_min_size = Vector2(0, 30 * log_line.get_line_count())
	
	vbox.add_child(log_line)
