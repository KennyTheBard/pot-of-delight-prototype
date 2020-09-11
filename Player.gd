extends Node2D

signal sanity_changed(sanity)
signal courage_changed(courage)
signal serenity_changed(serenity)
signal hope_changed(hope)
signal enter_state(state, state_type)
signal player_died

signal attack_enemy(attack_name, has_bonus)

var sanity : int = 100
var courage : int = 100
var serenity : int = 100
var hope : int = 100

var player_turn : bool

var state : String

func take_damage(damage : int, damage_type : String) -> void:
	match damage_type.to_lower():
		"sanity":
			sanity -= damage
			if sanity <= 0:
				if state.empty():
					state = "insane"
					emit_signal("enter_state", state, "sanity")
				elif state != "insane":
					emit_signal("player_died")
			emit_signal("sanity_changed", sanity)
			
		"courage":
			courage -= damage
			if courage <= 0:
				if state.empty():
					state = "terrified"
					emit_signal("enter_state", state, "courage")
				elif state != "terrified":
					emit_signal("player_died")
			emit_signal("courage_changed", courage)
			
		"serenity":
			serenity -= damage
			if serenity <= 0:
				if state.empty():
					state = "enraged"
					emit_signal("enter_state", state, "serenity")
				elif state != "enraged":
					emit_signal("player_died")
			emit_signal("serenity_changed", serenity)
			
		"hope":
			hope -= damage
			if sanity <= 0:
				if state.empty():
					state = "hysteric"
					emit_signal("enter_state", state, "hope")
				elif state != "hysteric":
					emit_signal("player_died")
			emit_signal("hope_changed", hope)


func _on_Prototype_player_turn():
	player_turn = true


func _on_Dyslexia_pressed():
	execute_turn("Dyslexia", state == "insane")


func _on_DarkThoughts_pressed():
	execute_turn("Dark Thoughts", state == "insane")


func _on_Roar_pressed():
	execute_turn("Roar", state == "insane")


func _on_Charge_pressed():
	execute_turn("Charge", state == "insane")


func execute_turn(attack_name, has_bonus : bool):
	if player_turn:
		player_turn = false
		emit_signal("attack_enemy", attack_name, has_bonus)
