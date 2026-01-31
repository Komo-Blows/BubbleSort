class_name CharacterStack
extends Node2D

func push(character: StackCharacter) -> void:
	add_child(character)
	character.visible = false
	update_visibility()

func accept_mask(mask: Mask) -> StackCharacter:
	if get_child_count() == 0:
		mask.queue_free()
		return null
	var character = get_child(0) as StackCharacter
	remove_child(character)
	var acceptance: StackCharacter.SATISFACTIONLEVEL = character.accept_mask(mask)
	self.update_visibility()
	print(acceptance)
	return character

func peek() -> StackCharacter:
	if get_child_count() == 0:
		return null
	return get_child(0) as StackCharacter

func size() -> int:
	return get_child_count()

func is_empty() -> bool:
	return get_child_count() == 0

func update_visibility() -> void:
	for i in get_child_count():
		var character = get_child(i) as StackCharacter
		character.visible = (i == 0) #only front character should be visible.
