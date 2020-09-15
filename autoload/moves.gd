extends Node

onready var Emotion = emotions.Emotion

class Move:
	var name : String
	var type : int
	var min_damage : int
	var max_damage : int
	var cost : int
	
	func _init(name, type, min_damage, max_damage, cost):
		self.name = name
		self.type = type
		self.min_damage = min_damage
		self.max_damage = max_damage
		self.cost = cost
	
	func get_damage(modifier : float = 0.0) -> int:
		var random_damage = rand_range(min_damage, max_damage)
		return int(round(random_damage * modifier))


onready var MoveSet : Dictionary = {
	"Puke": Move.new("Puke", Emotion.DISGUST, 10, 20, 3),
	"Closet Monster": Move.new("Closet Monster", Emotion.FEAR, 15, 25, 7),
	"Roar": Move.new("Roar", Emotion.ANGER, 17, 22, 7),
	"Dark Thoughts": Move.new("Dark Thoughts", Emotion.SADNESS, 13, 18, 4)
}
