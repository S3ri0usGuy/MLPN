extends HitBox

@export var damage :float = 25

func  _init() -> void:
	collision_layer = 4
	collision_mask = 0
