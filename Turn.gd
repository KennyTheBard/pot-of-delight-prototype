extends Label

onready var tween : Tween = $Tween
onready var options : Array = [Vector2(1, 1), Vector2(1.35, 1.35)]


func _ready():
	_tween_start()


func _tween_start():
	tween.interpolate_property(self, "rect_scale",
		options[0], options[1], 0.5,
		Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
	tween.start()


func _on_Tween_tween_completed(object, key):
	options.invert()
	_tween_start()


func _on_Arena_turn(whos_turn):
	text = whos_turn
