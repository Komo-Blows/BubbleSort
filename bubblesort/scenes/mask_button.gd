extends Button

@onready
var animator = $animator
@onready
var audio = $AudioStreamPlayer2D

var mask_object: Mask

func _on_pressed() -> void:
	Signals.mask_shape_selected.emit(mask_object)
	audio.play()
