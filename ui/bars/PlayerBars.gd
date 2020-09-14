extends Control

onready var Emotion = emotions.Emotion

onready var bars : Dictionary = {
	Emotion.SADNESS: $SadnessBar,
	Emotion.FEAR: $FearBar,
	Emotion.DISGUST: $DisgustBar,
	Emotion.ANGER: $AngerBar
}


func _on_Player_emotion_changed(emotion, emotion_value):
	bars[emotion].value = emotion_value
