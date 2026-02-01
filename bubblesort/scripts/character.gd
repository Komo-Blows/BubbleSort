extends Node2D

@onready var sprite = $sprite

@export
var current_character : character
var characters : Array[character] = []
var recent_characters : Array[character] = []
	
enum SatisfactionLevel {
	HAPPY,
	MEH,
	UPSET
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
	
	update_character(current_character)

@onready
var audio = $AudioStreamPlayer2D
func update():
	while true:
		current_character = characters.pick_random()
		if !recent_characters.has(current_character):
			break
	print(recent_characters)
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
	var current_char_major_aesth: Globals.aesthetics = self.current_character.major
	var current_char_minor_aesth: Globals.aesthetics = self.current_character.minor
	var major_score: int = mask.aesthetic.get_dict()[current_char_major_aesth]
	var minor_score: int = mask.aesthetic.get_dict()[current_char_minor_aesth]
	var satisfaction_level: SatisfactionLevel = self.calculate_satisfaction(major_score, minor_score)
	return self.display_reaction(satisfaction_level)
	
	
## Given the mask scores for the current character's major and minor aesthetics,
## calculates a satisfaction level for the character.
func calculate_satisfaction(major_score: int, minor_score: int) -> SatisfactionLevel:
	var total_score: int = 0
	total_score += major_score * self.current_character.major_multiplier
	total_score += minor_score * self.current_character.minor_multiplier
	var satisfaction_limit: int = self.current_character.happy_satisfaction_level
	# Range split is 0<->0.4, 0.4<->0.75, 0.75+ for upset, meh, and happy respectively.
	if total_score < (0.4 * satisfaction_limit):
		return SatisfactionLevel.UPSET
	elif (0.4 * satisfaction_limit) <= total_score and total_score <= (0.75 * satisfaction_limit):
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
	
## Given a satisfaction level, provides a texture for that satisfaction level.
func get_emoji_texture(sl: SatisfactionLevel) -> Texture2D:
	match sl:
		SatisfactionLevel.MEH: \
		return preload("res://sprites/characters/reactions/blank-smile-blue-emoji-yellow.png")
		SatisfactionLevel.UPSET: \
		return preload("res://sprites/characters/reactions/frustrated-blue-emoji-red.png")
	# Default return is SatisfactionLevel.HAPPY	
	return preload("res://sprites/characters/reactions/ok-sign-blue-emoji-green.png")
