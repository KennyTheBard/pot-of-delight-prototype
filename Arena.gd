extends Node2D

signal logs(user, move_name, move_type, damage)

onready var player = $Player
onready var enemy = $Enemy

var attacks = preload("res://attacks.gd").attacks

# Called when the node enters the scene tree for the first time.
func _ready():
	if randi() % 2 == 0:
		enemy.execute_turn()
	else:
		player.player_turn = true


func attack(attacker, attacked, attack_name):
	var attack
	for a in attacks:
		if a["name"] == attack_name:
			attack = a
			break
	var damage = int(round(rand_range(attack["min_damage"], attack["max_damage"])))
	attacked.take_damage(damage, attack["type"])
	attacker.take_damage(attack["cost"], attack["type"])
	
	# logs
	var user = "Enemy"
	if attacker == player:
		user = "Player"
	emit_signal("logs", user, attack["name"], attack["type"], damage)


func _on_Enemy_attack_player(attack_name):
	attack(enemy, player, attack_name)
	player.player_turn = true


func _on_Player_attack_enemy(attack_name):
	attack(player, enemy, attack_name)
	enemy.execute_turn()
