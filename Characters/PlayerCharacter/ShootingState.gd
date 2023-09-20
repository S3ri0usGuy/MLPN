extends State

const Nine_Mm_Bullet_Scene = preload("res://Objects/Bullets/9_mm_bullet.tscn")
const Nine_Mm_Bullet_Script = preload("res://Objects/Bullets/9_mm_bullet.gd")

@export var state_machine :CharacterStateMachine
@export var ground_state :State
@export var aim_state :State

@onready var timer : Timer = $Timer



func on_enter():
	timer.start(0.5)

func state_process(delta):
	#_on_timer_timeout()
	pass

func on_exit():
#	state_machine.Previous_State = ground_state
	#print( str(timer.is_stopped()))
	pass

func _on_timer_timeout():
	if state_machine.Current_State != state_machine.Previous_State:
		Next_State = state_machine.Previous_State
	else:
		Next_State = ground_state
