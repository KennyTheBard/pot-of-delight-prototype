extends Node2D

signal attack_player(attack_name)
signal health_changed(health)
signal set_max_health(health)

export(float) var scale_period = 1.5
export(float) var scale_difference = 0.01

export(int) var max_health = 1000

onready var sprite : Sprite = $Sprite
onready var scale_tween : Tween = $Sprite/ScaleTween
onready var scale_tween_values : Array = [sprite.scale , sprite.scale + Vector2(scale_difference, scale_difference)]
onready var translate_tween : Tween = $Sprite/TranslateTween


var moves = ["Puke", "Closet Monster"]

var health


func _ready():
	health = max_health
	emit_signal("set_max_health", max_health)
	_start_scale_tween()


func execute_turn():
	$TurnTimer.start(1)


func _on_TurnTimer_timeout():
	var random_move = moves[randi() % moves.size()]
	emit_signal("attack_player", random_move)
	_start_translate_tween()


func take_damage(damage, damage_type):
	health -= damage
	emit_signal("health_changed", health)


func _start_scale_tween() -> void:
	scale_tween.interpolate_property(sprite, "scale",
		scale_tween_values[0], scale_tween_values[1], scale_period,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0.2)
	scale_tween.start()


func _start_translate_tween() -> void:
	# go forward animation
	translate_tween.interpolate_property(sprite, "global_position",
		sprite.global_position, sprite.global_position - Vector2(50, 0), 0.05,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	translate_tween.start()
	
	# wait for first animation to complete
	yield(translate_tween, "tween_completed")

	# return animation
	translate_tween.interpolate_property(sprite, "global_position",
		sprite.global_position, sprite.global_position + Vector2(50, 0), 0.3,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	translate_tween.start()


func _on_ScaleTween_tween_completed(object, key):
	scale_tween_values.invert()
	_start_scale_tween()

