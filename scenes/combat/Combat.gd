extends Node


func _ready():
	$End/Container.visible = false


func _on_Exit_pressed():
	get_tree().quit()


func _on_Replay_pressed():
	get_tree().reload_current_scene()


func _on_Player_player_died():
	end_game(false)


func _on_Enemy_enemy_died():
	end_game(true)


func end_game(winner : bool):
	if winner:
		$End/Container/Result.text = "You win!"
	else:
		$End/Container/Result.text = "You died..."
	$HUD.pause_mode = true
	$Arena.pause_mode = true
	$End/Container.visible = true
