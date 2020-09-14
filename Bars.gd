extends Control

var bars : Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		bars[child.name] = child


func _on_Player_courage_changed(courage):
	$Courage.value = courage
	if courage <= 0:
		get_parent().get_node("State").modulate = Color(1, 0, 0)
		get_parent().get_node("State").visible = true


func _on_Player_hope_changed(hope):
	$Hope.value = hope
	if hope <= 0:
		get_parent().get_node("State").modulate = Color(0, 1, 1)
		get_parent().get_node("State").visible = true


func _on_Player_sanity_changed(sanity):
	$Sanity.value = sanity
	if sanity <= 0:
		get_parent().get_node("State").modulate = Color(1, 1, 0)
		get_parent().get_node("State").visible = true


func _on_Player_serenity_changed(serenity):
	$Serenity.value = serenity
	if serenity <= 0:
		get_parent().get_node("State").modulate = Color(0, 1, 0)
		get_parent().get_node("State").visible = true
