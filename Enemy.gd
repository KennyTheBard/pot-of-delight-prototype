extends Node2D

signal use_move(move_name, move_color, damage, damage_type)

export(float) var scale_period = 1.5
export(float) var scale_difference = 0.01

onready var sprite : Sprite = $Sprite
onready var scale_tween : Tween = $Sprite/ScaleTween
onready var scale_tween_values : Array = [sprite.scale , sprite.scale + Vector2(scale_difference, scale_difference)]


var moves = [
	{
		"name": "Puke",
		"name_color": "#22BB22",
		"damage_min": 15,
		"damage_max": 20,
		"damage_type": "serenity"
	},
	{
		"name": "Closet Monster",
		"name_color": "#CC1616",
		"damage_min": 20,
		"damage_max": 25,
		"damage_type": "courage"
	}
]


func _ready():
	_start_scale_tween()


func execute_turn(arena):
	var random_move = moves[randi() % moves.size()]
	var damage = int(round(rand_range(random_move["damage_min"], random_move["damage_max"])))
	arena.get_node("Player").damage(damage, random_move["damage_type"])
	emit_signal("use_move", random_move["name"], random_move["name_color"], damage, random_move["damage_type"])

func _start_scale_tween() -> void:
	scale_tween.interpolate_property(sprite, "scale",
		scale_tween_values[0], scale_tween_values[1], scale_period,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0.2)
	scale_tween.start()


func _on_ScaleTween_tween_completed(object, key):
	scale_tween_values.invert()
	_start_scale_tween()

