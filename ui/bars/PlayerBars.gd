extends Control

export(float) var max_behaviour_period = 0.25

onready var bars : Dictionary = {
	emotions.Emotion.SADNESS: $SadnessBar,
	emotions.Emotion.FEAR: $FearBar,
	emotions.Emotion.DISGUST: $DisgustBar,
	emotions.Emotion.ANGER: $AngerBar
}
onready var sync_timer : Timer = $SyncTimer


func _ready():
	for bar in bars.values():
		bar.max_behaviour_period = max_behaviour_period
	sync_timer.start(2 * max_behaviour_period)

func set_emotion_value(emotion, emotion_value):
	bars[emotion].value = emotion_value


func set_emotion_max_value(emotion, max_value):
	bars[emotion].max_value = max_value


func _on_SyncTimer_timeout():
	for bar in bars.values():
		bar.start_max_behaviour()
