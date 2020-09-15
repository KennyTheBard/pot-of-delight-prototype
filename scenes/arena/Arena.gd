extends Node2D

signal logs(user, move_name, move_type, damage)
signal turn(whos_turn)

onready var player = $Player
onready var enemy = $Enemy

var MoveSet = moves.MoveSet

# Called when the node enters the scene tree for the first time.
func _ready():
	if randi() % 2 == 0:
		enemy.execute_turn()
	else:
		player.player_turn = true


func attack(attacker, attacked, attack_name, has_bonus: bool):
	var attack
	for a in MoveSet.keys():
		if a == attack_name:
			attack = MoveSet[a]
			break
	var modifier : float = 1.0
	if has_bonus:
		modifier = 1.25
	var damage = int(round(rand_range(attack["min_damage"], attack["max_damage"]) * modifier))
	attacked.take_damage(damage, attack["type"])
	attacker.take_damage(attack["cost"], attack["type"])
	
	# logs
	var user = "Enemy"
	if attacker == player:
		user = "Player"
	emit_signal("logs", user, attack["name"], attack["type"], damage)


func _on_Enemy_attack_player(attack_name):
	attack(enemy, player, attack_name, false)
	emit_signal("turn", "Your turn")
	player.player_turn = true


func _on_Player_attack_enemy(attack_name, has_bonus):
	attack(player, enemy, attack_name, has_bonus)
	emit_signal("turn", "Enemy turn")
	enemy.execute_turn()
