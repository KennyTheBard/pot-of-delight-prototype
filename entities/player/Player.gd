extends "res://entities/BaseEntity.gd"

signal emotion_changed(emotion, emotion_value)
signal enter_state(emotion)
signal player_died

onready var Emotion = emotions.Emotion

export(int) var max_sadness = 100
export(int) var max_fear = 100
export(int) var max_disgust = 100
export(int) var max_anger = 100

onready var max_emotions_value : Dictionary = {
	Emotion.SADNESS: max_sadness,
	Emotion.FEAR: max_fear,
	Emotion.DISGUST: max_disgust,
	Emotion.ANGER: max_anger
}
onready var emotions_value : Dictionary = {
	Emotion.SADNESS: max_sadness,
	Emotion.FEAR: max_fear,
	Emotion.DISGUST: max_disgust,
	Emotion.ANGER: max_anger
}
onready var emotional_state : Dictionary = {
	Emotion.SADNESS: false,
	Emotion.FEAR: false,
	Emotion.DISGUST: false,
	Emotion.ANGER: false
}

var player_turn : bool


func has_died() -> bool:
	for k in emotional_state.values():
		if k == false:
			return false
	return true


func take_damage(damage : int, emotion : int) -> void:
	emotions_value[emotion] += damage
	if emotions_value[emotion] >= max_emotions_value[emotion]:
		emotions_value[emotion] = max_emotions_value[emotion]
		if emotional_state[emotion]:
			emotional_state[emotion] = true
			if has_died():
				emit_signal("player_died")
			else:
				emit_signal("enter_state", emotion)
	else:
		emit_signal("emotion_changed", emotion, emotions_value[emotion])


func _on_Prototype_player_turn():
	player_turn = true


func execute_turn(attack_name, has_bonus : bool):
	if player_turn:
		player_turn = false
		emit_signal("use_move", attack_name, has_bonus)


func _on_MoveMenu_use_move(move_name):
	emit_signal("use_move", move_name)
