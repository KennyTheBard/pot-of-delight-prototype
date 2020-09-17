extends TextureProgress

export(Color) var progress_color = Color(1, 1, 1)

export(String) var label_text = ""
export(bool) var special_max_behaviour = false
export(String) var max_value_text = ""
export(float) var max_behaviour_period = 0.25

onready var label = $BarLabel
onready var lighten_tween = $LightenTween
onready var darken_tween = $DarkenTween

var start_behaviour : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# set label text
	label.text = label_text
	label.rect_min_size = rect_min_size
	label.rect_size = rect_size + Vector2(0, 25)
	
	# set a new gradient texture for each bar in order to work independently
	var tex = GradientTexture.new()
	var grad = Gradient.new()
	grad.colors = PoolColorArray([])
	grad.offsets = PoolRealArray([])
	grad.add_point(0, Color.white)
	tex.gradient = grad
	texture_progress = tex
	
	# set tint color
	tint_progress = progress_color


func _on_LightenTween_tween_completed(object, key):
	darken_tween.interpolate_property(self, "tint_progress",
		tint_progress, progress_color, max_behaviour_period,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	darken_tween.start()


func _on_DarkenTween_tween_completed(object, key):
	lighten_tween.interpolate_property(self, "tint_progress",
		progress_color, lerp(progress_color, Color.white, 0.9), max_behaviour_period,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	lighten_tween.start()



func _on_EmotionBar_value_changed(value):
	if value == max_value and special_max_behaviour:
		start_behaviour = true
	else:
		# reset label state
		label.text = label_text
		label.toggle_max_behaviour(false)
		# reset state for progress color
		lighten_tween.stop_all()
		darken_tween.stop_all()
		tint_progress = progress_color


func start_max_behaviour():
	if start_behaviour:
		start_behaviour = false
		# set label max behaviour
		label.text = max_value_text
		label.toggle_max_behaviour(true)
		# start color max behaviour synchronous
		_on_LightenTween_tween_completed(null, null)

