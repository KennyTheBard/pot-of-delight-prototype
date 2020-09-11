extends Control


onready var vbox = $VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func color_of_damage_type(move_type: String) -> Color:
	match move_type.to_lower():
		"sanity":
			return Color(1, 1, 0)
		"courage":
			return Color(1, 0, 0)
		"serenity":
			return Color(0, 1, 0)
		"hope":
			return Color(0, 1, 1)
	return Color(0.4, 0.4, 0.4)


func _on_Arena_logs(user, move_name, move_type, damage):
	var log_line = RichTextLabel.new()
	log_line.bbcode_enabled = true
	
	var move_color : Color = color_of_damage_type(move_type)
	var move : String = "[color=#" + move_color.to_html(false) + "]" + move_name.to_upper() + "[/color]"
	log_line.bbcode_text = user + " used " + move + " for " + str(damage) + " damage."
	log_line.rect_min_size = Vector2(0, 30 * log_line.get_line_count())
	
	vbox.add_child(log_line)
