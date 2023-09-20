extends Marker2D

@export var player : PlayerCharacter
@export var facing_marker :Marker2D
@export var Facing_Left_Position :Vector2
@export var Facing_Right_Position :Vector2

func  _ready():
	player.connect("Facing_Direction_Changed", _On_Player_Facing_Direction_Changed)

func  _On_Player_Facing_Direction_Changed(Facing_Right :bool):
	if(Facing_Right):
		facing_marker.position = facing_marker.Facing_Right_Position
	else :
		facing_marker.position = facing_marker.Facing_Left_Position
