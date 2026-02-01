extends Node

#references
@onready var audio_player_1 = $audio_player_1
@onready var audio_player_2 = $audio_player_2
@onready var audio_fader = $audio_fader #can animate anything about audio players

func _ready() -> void:
	Signals.connect("switch_theme", switch) #this lets any node play a song

var current_player = 1
# song is a loaded song, not a filepath
func switch():
	print("switch")
	if current_player == 1:
		current_player = 2
		audio_fader.play("play_title")
		await audio_fader.animation_finished
		audio_player_1.volume_db = -80
		audio_player_2.volume_db = 0
	if current_player == 2:
		current_player = 1
		audio_fader.play("play_title")
