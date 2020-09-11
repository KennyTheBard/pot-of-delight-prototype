extends TextureProgress


func _on_Enemy_health_changed(health):
	value = health


func _on_Enemy_set_max_health(health):
	max_value = health
	value = health
