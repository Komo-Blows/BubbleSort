extends Button

@onready
var animator = $animator
@onready
var audio = $AudioStreamPlayer2D

var mask_object: Mask

func _on_pressed() -> void:
	Signals.mask_shape_selected.emit(mask_object)
	audio.play()

@onready
var info_bubble = $Label
func _ready() -> void:
	var text_to_bubble = ""
	for key in mask_object.aesthetic.get_dict():
		if mask_object.aesthetic.get_dict()[key] != 0:
			#print(aesthetic_dict)
			text_to_bubble += str(Globals.aesthetics.keys()[key]) + " : " + str(mask_object.aesthetic.get_dict()[key]) + "\n"
	info_bubble.text = text_to_bubble

@onready
var timer = $Timer
func _on_mouse_entered() -> void:
	timer.start()

func _on_mouse_exited() -> void:
	hide_info()
	timer.stop()

func display_info():
	info_bubble.visible = true

func hide_info():
	info_bubble.visible = false
	timer.stop()





func _on_timer_timeout() -> void:
	display_info()
