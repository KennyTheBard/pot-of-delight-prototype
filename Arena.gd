extends Node2D

onready var player = $Player
onready var enemy = $Enemy

var attacks = [
	{
		"name": "Puke",
		"type": "Serenity",
		"min_damage": 10,
		"max_damage": 20,
		"cost" : 3
	},
	{
		"name": "Closet Monster",
		"type": "Courage",
		"min_damage": 15,
		"max_damage": 25,
		"cost" : 7
	},
	{
		"name": "Dyslexia",
		"type": "Sanity",
		"min_damage": 17,
		"max_damage": 22,
		"cost" : 7
	},
	{
		"name": "Dark Thoughts",
		"type": "Hope",
		"min_damage": 13,
		"max_damage": 18,
		"cost" : 4
	},
	{
		"name": "Roar",
		"type": "Courage",
		"min_damage": 14,
		"max_damage": 19,
		"cost" : 4
	},
	{
		"name": "Charges",
		"type": "Serenity",
		"min_damage": 17,
		"max_damage": 19,
		"cost" : 5
	},
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func attack(attacker, attacked, attack_name):
	var attack
	for a in attacks:
		if a["name"] == attack_name:
			attack = a
			break
	var damage = int(round(rand_range(attack["damage_min"], attack["damage_max"])))
	attacked.take_damage(damage, attack["type"])
	attacker.take_damage(attack["cost"], attack["type"])


func _on_Enemy_attack_player(attack_name):
	attack(enemy, player, attack_name)


func _on_Player_attack_enemy(attack_name):
	attack(player, enemy, attack_name)
