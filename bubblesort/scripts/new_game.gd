extends Button



func _on_pressed() -> void:
	SaveManager.load_save()
	Signals.switch_theme.emit()
