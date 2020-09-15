extends Node2D

onready var player = $Combatants/Player
onready var enemy = $Combatants/Enemy
onready var logs = $HUD/Logs

var move_set = moves.MoveSet

func _ready():
	logs.log_attack("test", "puke", emotions.Emotion.DISGUST, 10)


func attack(attacker, attacked, attack_name):
	var move : moves.Move = move_set[attack_name]
	var damage = move.get_damage()
	attacked.take_damage(damage, move.type)
	attacker.take_damage(move.cost, move.type)
	
	# logs
	var user = "Enemy"
	if attacker == player:
		user = "Player"
	logs.log_attack(user, move.name, move.type, damage)


func _on_Enemy_attack_player(attack_name):
	attack(enemy, player, attack_name)
	emit_signal("turn", "Your turn")
	player.player_turn = true


func _on_Player_attack_enemy(attack_name):
	attack(player, enemy, attack_name)
	emit_signal("turn", "Enemy turn")
	enemy.execute_turn()
