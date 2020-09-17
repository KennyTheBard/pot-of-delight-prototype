extends TextureProgress

export(String) var label_text = ""
export(bool) var special_max_behaviour = false
export(String) var max_value_text = ""
export(Color) var progress_color = Color(1, 1, 1)

onready var label = $BarLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	# set label text
	label.text = label_text
	label.rect_min_size = rect_min_size
	label.rect_size = rect_size + Vector2(0, 25)
	
	# set progress bar color
	var tex = GradientTexture.new()
	var grad = Gradient.new()
	grad.colors = PoolColorArray([])
	grad.offsets = PoolRealArray([])
	grad.add_point(0, progress_color)
	tex.gradient = grad
	texture_progress = tex


func _on_EmotionBar_value_changed(value):
	if value == max_value and special_max_behaviour:
		label.text = max_value_text
		label.toggle_max_behaviour(true)
	else:
		label.text = label_text
		label.toggle_max_behaviour(false)

