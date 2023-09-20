extends Label

@export var character :PlayerCharacter

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "stamina: " + str(character.stamina)+"\n" + "Health" + str(character.health)#str(character.weapon_id_used)
	if character.health <= 0:
		text = "dead"
