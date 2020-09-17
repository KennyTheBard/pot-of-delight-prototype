extends Label

export(int) var font_initial_size = 14
export(int) var font_increase = 4
export(float) var font_resize_period = 0.25

onready var font_file = preload("res://assets/fonts/Kenney Space.ttf")
onready var font_resize_tween = $FontResizeTween

var resizing : bool = false
var font : DynamicFont


func _ready():
	font = DynamicFont.new()
	font.font_data = font_file
	font.size = font_initial_size
	font.outline_size = 2
	font.outline_color = Color.black
	add_font_override("font", font)


func _scale_font_up():
	font_resize_tween.interpolate_property(font, "size",
		font.size, font.size + font_increase, font_resize_period,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	font_resize_tween.start()
	
	yield(font_resize_tween, "tween_completed")
	_scale_font_down()


func _scale_font_down():
	font_resize_tween.interpolate_property(font, "size",
		font.size, font.size - font_increase, font_resize_period,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	font_resize_tween.start()
	
	yield(font_resize_tween, "tween_completed")
	_scale_font_up()


func toggle_max_behaviour(reached):
	if reached:
		if not resizing:
			resizing = true
			_scale_font_up()
	else:
		resizing = false
		font_resize_tween.stop_all()
		font.size = font_initial_size
