class_name Mask
extends Sprite2D
enum MASKTYPE {
	NONE,
	HAPPY,
	SAD,
	BLAH
}
enum CHARMTYPE {
	NONE
}

'''
Below are interface methods for describing a mask.
This object is an interface, so cannot be called directly.
'''

## Gets the mask type of this mask.
func get_mask_type() -> MASKTYPE:
	push_error("get_mask_type() is not implemented in " + get_script().resource_path)
	return MASKTYPE.NONE
	
## Gets the main value score of this mask.
func get_main_value() -> int:
	push_error("get_main_value() is not implemented in " + get_script().resource_path)
	return 0
	
## Gets the secondary attribute score of this mask.
func get_secondary_attribute() -> int:
	push_error("get_secondary_attribute() is not implemented in " + get_script().resource_path)
	return 0
