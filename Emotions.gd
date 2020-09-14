extends Node

enum Emotion {
	ERROR,
	SADNESS,
	FEAR,
	DISGUST,
	ANGER,
	DELIGHT
}


func string_to_emotion(emotion_name: String) -> int:
	match emotion_name.to_upper():
		"SADNESS":
			return Emotion.SADNESS
		"FEAR":
			return Emotion.FEAR
		"DISGUST":
			return Emotion.DISGUST
		"ANGER":
			return Emotion.ANGER
		"DELIGHT":
			return Emotion.DELIGHT
	return Emotion.ERROR


func emotion_to_string(emotion: int) -> String:
	match emotion:
		Emotion.SADNESS:
			return "SADNESS"
		Emotion.FEAR:
			return "FEAR"
		Emotion.DISGUST:
			return "DISGUST"
		Emotion.ANGER:
			return "ANGER"
		Emotion.DELIGHT:
			return "DELIGHT"
	return "ERROR"
