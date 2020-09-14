extends TextureProgress

export(String) var label_text = ""
export(Color) var progress_color = Color(1, 1, 1)
export(Texture) var status_icon

# Called when the node enters the scene tree for the first time.
func _ready():
	# set label text
	$BarLabel.text = label_text
	$BarLabel.rect_min_size = rect_min_size
	
	# set progress bar color
	var tex = GradientTexture.new()
	var grad = Gradient.new()
	grad.colors = PoolColorArray([])
	grad.offsets = PoolRealArray([])
	grad.add_point(0, progress_color)
	tex.gradient = grad
	texture_progress = tex
	
	# set status icon
	$StatusIcon.texture = status_icon


func _on_EmotionBar_value_changed(value):
	$StatusIcon.visible = (value == max_value)


func _on_EmotionBar_resized():
	$BarLabel.rect_size = rect_size
