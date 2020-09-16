extends Node

onready var player = $Combatants/Player
onready var enemy = $Combatants/Enemy
onready var logs = $HUD/Logs

onready var move_set = moves.MoveSet


func _ready():
	if randi() % 2 == 0:
		enemy.execute_turn()
	else:
		player.execute_turn()


func attack(attacker, attacked, move_name):
	var move : moves.Move = move_set.get(move_name)
	var damage = move.get_damage()
	attacked.take_damage(damage, move.type)
	attacker.take_damage(move.cost, move.type)
	
	# logs
	if attacker == player:
		logs.log_attack("Player", move.name, move.type, damage)
	else:
		logs.log_attack("Enemy", move.name, move.type, damage, true)


func _on_Player_use_move(move_name):
	attack(player, enemy, move_name)
	enemy.execute_turn()


func _on_Enemy_use_move(move_name):
	attack(enemy, player, move_name)
	player.execute_turn()
	yield(player, "turn_completed")
