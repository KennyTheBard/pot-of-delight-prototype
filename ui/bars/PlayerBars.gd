extends Control

onready var Emotion = emotions.Emotion

onready var bars : Dictionary = {
	Emotion.SADNESS: $SadnessBar,
	Emotion.FEAR: $FearBar,
	Emotion.DISGUST: $DisgustBar,
	Emotion.ANGER: $AngerBar
}


func set_emotion_value(emotion, emotion_value):
	bars[emotion].value = emotion_value


func set_emotion_max_value(emotion, max_value):
	bars[emotion].max_value = max_value
