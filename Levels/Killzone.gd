extends Area2D
@export var player :PlayerCharacter
@export var nuke :Nuke

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var bodies = self.get_overlapping_bodies()
	#print(bodies)
	for body in bodies:
		print(body)
		if body.name == "Nuke":
			#print(body)
			#print(player.get_position())
			nuke.freeze = true
			nuke.position = player.get_position()
			nuke.freeze = false
			print("debil")
		if body.name == "Player":
			player.queue_free()
