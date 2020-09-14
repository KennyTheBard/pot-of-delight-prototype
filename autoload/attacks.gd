extends Node

onready var Emotion = emotions.Emotion

onready var MoveSet : Dictionary = {
	"Puke": {
		"name": "Puke",
		"type": Emotion.DISGUST,
		"min_damage": 10,
		"max_damage": 20,
		"cost" : 3
	},
	"Closet Monster": {
		"type": Emotion.FEAR,
		"min_damage": 15,
		"max_damage": 25,
		"cost" : 7
	},
	"Roar": {
		"type": Emotion.ANGER,
		"min_damage": 17,
		"max_damage": 22,
		"cost" : 7
	},
	"Dark Thoughts": {
		"type": Emotion.SADNESS,
		"min_damage": 13,
		"max_damage": 18,
		"cost" : 4
	}
}
