extends HitBox

@export var damage : float = 50.0
@export var player :PlayerCharacter
@export var Facing_Shape : FacingCollisionShape2D

func  _init() -> void:
	collision_layer = 4
	collision_mask = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	player.connect("Facing_Direction_Changed", _On_Player_Facing_Direction_Changed) 

func  _On_Player_Facing_Direction_Changed(Facing_Right :bool):
	if(Facing_Right):
		Facing_Shape.position = Facing_Shape.Facing_Right_Position
	else :
		Facing_Shape.position = Facing_Shape.Facing_Left_Position
