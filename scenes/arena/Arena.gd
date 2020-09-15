extends Node

onready var player = $Combatants/Player
onready var enemy = $Combatants/Enemy
onready var logs = $HUD/Logs

onready var move_set = moves.MoveSet


func attack(attacker, attacked, move_name):
	var move : moves.Move = move_set.get(move_name)
	var damage = move.get_damage()
	attacked.take_damage(damage, move.type)
	attacker.take_damage(move.cost, move.type)
	
	# logs
	var user = "Enemy"
	if attacker == player:
		user = "Player"
	logs.log_attack(user, move.name, move.type, damage)


func _on_Enemy_attack_player(move_name):
	attack(enemy, player, move_name)
	emit_signal("turn", "Your turn")
	player.player_turn = true


func _on_Player_attack_enemy(move_name):
	attack(player, enemy, move_name)
	emit_signal("turn", "Enemy turn")
	enemy.execute_turn()


func _on_Player_use_move(move_name):
	attack(player, enemy, move_name)
