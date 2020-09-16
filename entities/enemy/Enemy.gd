extends "res://entities/BaseEntity.gd"

signal health_changed(health)
signal set_max_health(health)
signal enemy_died

export(float) var scale_period = 1.5
export(float) var scale_difference = 0.01
export(float) var damage_color_period = 0.1

export(int) var max_health = 1000

export(Color) var damage_color_add = Color(1, 0, 0)
export(Color) var damage_color_substract = Color(0, 0.5, 0.5)

onready var sprite : Sprite = $Sprite
onready var scale_tween : Tween = $Sprite/ScaleTween
onready var translate_tween : Tween = $Sprite/TranslateTween
onready var damage_color_tween : Tween = $Sprite/DamageColorTween

onready var scale_tween_values : Array = [sprite.scale , sprite.scale + Vector2(scale_difference, scale_difference)]

onready var health_bar = $HUD/EnemyBar

var moves = ["Roar", "Closet Monster"]

var health


func _ready():
	# set initial health
	health = max_health
	
	# set healthbar parameters
	health_bar.max_value = max_health
	health_bar.value = health
	
	# start idle animation
	_start_scale_tween()


func execute_turn():
	$TurnTimer.start(1)


func _on_TurnTimer_timeout():
	var random_move = moves[randi() % moves.size()]
	emit_signal("use_move", random_move)
	_start_translate_tween()


func take_damage(damage, damage_type):
	health -= damage
	health_bar.value = health
	if health <= 0:
		emit_signal("enemy_died")

func _start_scale_tween() -> void:
	scale_tween.interpolate_property(sprite, "scale",
		scale_tween_values[0], scale_tween_values[1], scale_period,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0.2)
	scale_tween.start()


func _on_ScaleTween_tween_completed(object, key):
	scale_tween_values.invert()
	_start_scale_tween()
	_start_damage_color_tween()


func _start_damage_color_tween() -> void:
	var damage_color = damage_color_add - damage_color_substract
	damage_color_tween.interpolate_property(sprite, "modulate",
		sprite.modulate, sprite.modulate + damage_color, damage_color_period)
	damage_color_tween.start()
	
	yield(damage_color_tween, "tween_completed")

	damage_color_tween.interpolate_property(sprite, "modulate",
		sprite.modulate, sprite.modulate - damage_color, damage_color_period)
	damage_color_tween.start()


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
