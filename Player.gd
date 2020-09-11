extends Node2D

signal sanity_changed(sanity)
signal courage_changed(courage)
signal serenity_changed(serenity)
signal hope_changed(hope)

signal attack_enemy(attack_name)

var sanity : int = 100
var courage : int = 100
var serenity : int = 100
var hope : int = 100

var player_turn : bool


func take_damage(damage : int, damage_type : String) -> void:
	match damage_type.to_lower():
		"sanity":
			sanity -= damage
			emit_signal("sanity_changed", sanity)
		"courage":
			courage -= damage
			emit_signal("courage_changed", courage)
		"serenity":
			serenity -= damage
			emit_signal("serenity_changed", serenity)
		"hope":
			hope -= damage
			emit_signal("hope_changed", hope)


func _on_Prototype_player_turn():
	player_turn = true


func _on_Dyslexia_pressed():
	execute_turn("Dyslexia")


func _on_DarkThoughts_pressed():
	execute_turn("Dark Thoughts")


func _on_Roar_pressed():
	execute_turn("Roar")


func _on_Charge_pressed():
	execute_turn("Charge")


func execute_turn(attack_name):
	if player_turn:
		player_turn = false		
		emit_signal("attack_enemy", attack_name)
