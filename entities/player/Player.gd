extends "res://entities/BaseEntity.gd"

signal enter_state(emotion)
signal player_died

onready var Emotion = emotions.Emotion
onready var health_bars = $HUD/BattleMenu/PlayerBars
onready var move_menu = $HUD/BattleMenu/MoveMenu

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
onready var emotions_value : Dictionary
onready var emotional_state : Dictionary

var player_turn = false

func _ready():
	# prepare emotion states
	for emotion in max_emotions_value.keys():
		emotions_value[emotion] = 0
		emotional_state[emotion] = false
		health_bars.set_emotion_max_value(emotion, max_emotions_value.get(emotion))
		health_bars.set_emotion_value(emotion, 0)
	
	# prepare known moves
	for move in moves.MoveSet.values():
		move_menu.add_move(move)
	
	# prepare player name
	$HUD/BattleMenu/PCName.text = player_data.player["name"]


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
	
	# update corresponding health bar
	health_bars.set_emotion_value(emotion, emotions_value.get(emotion))


func execute_turn():
	move_menu.disable_buttons(false)


func _on_MoveMenu_use_move(move_name):
	emit_signal("use_move", move_name)
	move_menu.disable_buttons(true)
	emit_signal("turn_completed")
