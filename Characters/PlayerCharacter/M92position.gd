extends Sprite2D

@export var player : PlayerCharacter 

@export var Facing_Left_Position :Vector2
@export var Facing_Right_Position :Vector2

func _ready():
	player.connect("Facing_Direction_Changed", _On_Player_Facing_Direction_Changed) 

func  _On_Player_Facing_Direction_Changed(Facing_Right :bool):
	if(Facing_Right):
		self.position = self.Facing_Right_Position
		#self.flip_h = true
		self.flip_v = true
	else :
		self.position = self.Facing_Left_Position
		#self.flip_h = false
		self.flip_v = false
