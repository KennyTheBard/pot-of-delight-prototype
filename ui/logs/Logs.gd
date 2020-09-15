extends Control

export(int) var margin = 5

onready var scroll_container : ScrollContainer = $ScrollContainer
onready var vbox_container : VBoxContainer = $ScrollContainer/VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	scroll_container.rect_size = rect_size - Vector2(2 * margin, 2 * margin)
	scroll_container.rect_position = Vector2(margin, margin)


func color_of_damage_type(move_type: int) -> Color:
	match move_type:
		emotions.Emotion.SADNESS:
			return Color(0.482353, 0.690196, 1)
		emotions.Emotion.FEAR:
			return Color(1, 0.815686, 0.196078)
		emotions.Emotion.DISGUST:
			return Color(0.670588, 0.843137, 0)
		emotions.Emotion.ANGER:
			return Color(1, 0.427451, 0.262745)
	return Color(0.4, 0.4, 0.4)


func log_attack(user, move_name, move_type, damage):
	var move_color : Color = color_of_damage_type(move_type)
	var move : String = "[color=#" + move_color.to_html(false) + "]" + move_name.to_upper() + "[/color]"
	var text = user + " used " + move + " for " + str(damage) + " damage."
	_log(text)


func _on_Player_enter_state(state, state_type):
	var state_color : Color = color_of_damage_type(state_type)
	var state_text : String = "[color=#" + state_color.to_html(false) + "]" + state.to_upper() + "[/color]"
	var damage_state : String = "[color=#" + state_color.to_html(false) + "]" + state_type.to_upper() + "[/color]"
	var text = "Player has become " + state_text + ". Bonus " + damage_state + " damage."
	_log(text)


func _log(text: String) -> void:
	var log_line = RichTextLabel.new()
	log_line.bbcode_enabled = true
	log_line.bbcode_text = text
	vbox_container.add_child(log_line)
	yield(get_tree(), "idle_frame")
	log_line.rect_min_size.y = log_line.get_v_scroll().get_max()
	_scroll_down()


func _scroll_down():
	var bar : VScrollBar = $ScrollContainer.get_v_scrollbar()
	yield(bar, "changed")
	bar.value = bar.max_value
