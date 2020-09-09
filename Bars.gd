extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Player_courage_changed(courage):
	$Courage.value = courage


func _on_Player_hope_changed(hope):
	$Hope.value = hope


func _on_Player_sanity_changed(sanity):
	$Sanity.value = sanity


func _on_Player_serenity_changed(serenity):
	$Serenity.value = serenity
