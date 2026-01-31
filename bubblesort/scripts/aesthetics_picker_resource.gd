class_name aesthetics_picker
extends Resource
@export var techy: int = 0
@export var fishy: int = 0
@export var cutesy: int = 0
@export var preppy: int = 0
@export var ugly: int = 0
@export var demonic: int = 0
@export var cowboy: int = 0
@export var irish: int = 0
@export var badly_drawn: int = 0

func get_dict() -> Dictionary:
	# returns a global aesthetic-keyed dictionary
	return {
	Globals.aesthetics.techy: techy, 
	Globals.aesthetics.fishy: fishy,
	Globals.aesthetics.cutesy: cutesy,
	Globals.aesthetics.preppy: preppy,
	Globals.aesthetics.ugly: ugly,
	Globals.aesthetics.demonic: demonic,
	Globals.aesthetics.cowboy: cowboy,
	Globals.aesthetics.irish: irish,
	Globals.aesthetics.badly_drawn: badly_drawn,
	}

func add(new):
	techy += new.techy
	fishy += new.fishy
	cutesy += new.cutesy
	preppy += new.preppy
	ugly += new.ugly
	demonic += new.demonic
	cowboy += new.cowboy
	irish += new.irish
	badly_drawn += new.badly_drawn
