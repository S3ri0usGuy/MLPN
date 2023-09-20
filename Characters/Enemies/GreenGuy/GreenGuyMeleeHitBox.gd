extends HitBox

@export var damage :float = 10
@export var Facing_Shape :FacingCollisionShape2D
@export var character :Enemy

func  _init() -> void:
	collision_layer = 2
	collision_mask = 0

func _ready():
	character.connect("Facing_Direction_Changed", _On_Player_Facing_Direction_Changed)
	
func  _On_Player_Facing_Direction_Changed(Facing_Right :bool):
	if(Facing_Right):
		Facing_Shape.position = Facing_Shape.Facing_Right_Position
	else :
		Facing_Shape.position = Facing_Shape.Facing_Left_Position
