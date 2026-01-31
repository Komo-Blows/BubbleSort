extends Button

@onready
var animator = $animator

func _on_pressed() -> void:
	Signals.mask_shape_selected.emit()
