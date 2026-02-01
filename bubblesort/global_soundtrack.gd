extends Node

#references
@onready var title_player = $title
@onready var main_player = $main
@onready var audio_fader = $audio_fader #can animate anything about audio players

func _ready() -> void:
	Signals.switch_theme.connect(switch) #this lets any node play a song
	title_player.play()
	main_player.play()
	current_player = 1

var current_player = 1

func switch():
	if current_player == 1:
		current_player = 2
		audio_fader.play("play_main")
		await audio_fader.animation_finished
	elif current_player == 2:
		current_player = 1
		audio_fader.play("play_title")
