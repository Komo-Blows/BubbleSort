extends Node2D

@onready var sprite = $sprite

@export
var current_character : character
var characters : Array[character] = []
var recent_characters : Array[character] = []
	
enum SatisfactionLevel {
	HAPPY,
	MEH,
	UPSET,
	CHOPPED
}

func update_character(char : character):
	sprite.texture = char.image
	for child in get_children():
		if child is MaskScene:
			child.queue_free()

func _ready():
	var char_files = DirAccess.get_files_at("res://characters/")
	for file_name in char_files:
		if file_name.ends_with(".tres"):
			var file = "res://characters/" + file_name
			file = load(file)
			characters.append(file)
	assert(!characters.is_empty(), "no characters to load")
	
@onready
var audio = $AudioStreamPlayer2D
func update(force_character = null):
	if force_character:
		current_character = force_character
	else:
		current_character = characters.pick_random()
		if recent_characters.has(current_character):
			assert(false, 'current in recent')
	recent_characters.append(current_character)
	update_character(current_character)
	
	await get_tree().create_timer(1).timeout
	if current_character.sfx:
		audio.stream = current_character.sfx
		audio.play()

## Given a mask, weighs it against the current character's attributes,
## and displays a satisfaction emoji. Does not automatically cycle characters.
## Returns a tween for the satisfaction animation, with which the root can decide how to act.
func take_mask(mask: MaskScene) -> Tween:
	var satisfaction_level: SatisfactionLevel = self.calculate_reaction(mask)
	return self.display_reaction(satisfaction_level)
	
## Given the mask for the current character, calculates a satisfaction score for the character.
func calculate_satisfaction(mask: MaskScene) -> int:
	var current_char_major_aesth: Globals.aesthetics = self.current_character.major
	var current_char_minor_aesth: Globals.aesthetics = self.current_character.minor
	var major_score: int = mask.aesthetic.get_dict()[current_char_major_aesth]
	var minor_score: int = mask.aesthetic.get_dict()[current_char_minor_aesth]
	var total_score: int = 0
	total_score += major_score * self.current_character.major_multiplier
	total_score += minor_score * self.current_character.minor_multiplier
	return total_score
	
## Given the mask for the current character, calculates a satisfaction reaction for the character.
func calculate_reaction(mask: MaskScene) -> SatisfactionLevel:
	var total_score: int = self.calculate_satisfaction(mask)
	var satisfaction_limit: int = self.current_character.happy_satisfaction_level
	# Range split is [0, 0.3], (0.3, 0.6] (0.6, 0.8], 0.8+ portion of satisfaction level,
	# for chopped, upset, meh, happy respectively.
	if total_score <= (0.3 * satisfaction_limit):
		return SatisfactionLevel.CHOPPED
	elif (0.3 * satisfaction_limit) < total_score and total_score <= (0.6 * satisfaction_limit):
		return SatisfactionLevel.UPSET
	elif (0.6 * satisfaction_limit) < total_score and total_score <= (0.8 * satisfaction_limit):
		return SatisfactionLevel.MEH
	else:
		return SatisfactionLevel.HAPPY

## Given a satisfaction level, displays the reaction of this character, and fades it away.
func display_reaction(sl: SatisfactionLevel) -> Tween:
	var emoji = Sprite2D.new()
	emoji.texture = get_emoji_texture(sl)
	emoji.position = Vector2(0, -50)
	add_child(emoji)
	
	var tween = create_tween()
	tween.tween_property(emoji, "position", emoji.position + Vector2(0, 20), 0.8)
	tween.parallel().tween_property(emoji, "modulate:a", 0.0, 0.8).set_delay(0.3)
	tween.tween_callback(emoji.queue_free)
	return tween

#sfx
var upset_sfx = preload("res://audio/sad.wav")
var meh_sfx = preload("res://audio/neutral.wav")
var slight_sfx = preload("res://audio/happy.wav")
var happy_sfx = preload("res://audio/happiest.wav")


## Given a satisfaction level, provides a texture for that satisfaction level.
func get_emoji_texture(sl: SatisfactionLevel) -> Texture2D:
	match sl:
		SatisfactionLevel.MEH: 
			play_sfx(meh_sfx)
			return preload("res://sprites/characters/reactions/blank-smile-blue-emoji-yellow.png")
		SatisfactionLevel.UPSET: 
			play_sfx(upset_sfx)
			return preload("res://sprites/characters/reactions/frustrated-blue-emoji-red.png")
		SatisfactionLevel.CHOPPED: \
		return preload("res://sprites/characters/reactions/scared-and-defending-blue-emoji-black.png")
	# Default return is SatisfactionLevel.HAPPY	
	play_sfx(happy_sfx)
	return preload("res://sprites/characters/reactions/ok-sign-blue-emoji-green.png")

func play_sfx(sfx):
	audio.stream = sfx
	audio.play()
