extends Node2D

signal sanity_changed(sanity)
signal courage_changed(courage)
signal serenity_changed(serenity)
signal hope_changed(hope)

var sanity : int = 100
var courage : int = 100
var serenity : int = 100
var hope : int = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func damage(damage : int, damage_type : String) -> void:
	match damage_type:
		"sanity":
			sanity -= damage
			emit_signal("sanity_changed", sanity)
		"courage":
			courage -= damage
			emit_signal("courage_changed", courage)
		"serenity":
			serenity -= damage
			emit_signal("serenity_changed", serenity)
		"hope":
			hope -= damage
			emit_signal("hope_changed", hope)
