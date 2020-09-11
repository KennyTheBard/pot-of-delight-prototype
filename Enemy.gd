extends Node2D

signal attack_player(attack_name)
signal health_changed(health)

export(float) var scale_period = 1.5
export(float) var scale_difference = 0.01

export(int) var max_health = 100

onready var sprite : Sprite = $Sprite
onready var scale_tween : Tween = $Sprite/ScaleTween
onready var scale_tween_values : Array = [sprite.scale , sprite.scale + Vector2(scale_difference, scale_difference)]

var moves = ["Puke", "Closet Monster"]

var health


func _ready():
	health = max_health
	_start_scale_tween()


func execute_turn(arena):
	var random_move = moves[randi() % moves.size()]
	emit_signal("attack_player", random_move)


func take_damage(damage, damage_type):
	health -= damage
	emit_signal("health_changed", health)


func _start_scale_tween() -> void:
	scale_tween.interpolate_property(sprite, "scale",
		scale_tween_values[0], scale_tween_values[1], scale_period,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0.2)
	scale_tween.start()


func _on_ScaleTween_tween_completed(object, key):
	scale_tween_values.invert()
	_start_scale_tween()

