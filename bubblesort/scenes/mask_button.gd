extends Button

@onready
var animator = $animator

var mask_object: Mask

func _on_pressed() -> void:
	Signals.mask_shape_selected.emit(mask_object)
	
