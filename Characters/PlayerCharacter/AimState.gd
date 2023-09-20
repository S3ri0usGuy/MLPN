extends State

@export var state_machine :CharacterStateMachine
@export var ground_state :State
@export var air_state :State
@export var shooting_state :State
@export var stamina_consumption :float = 1

func on_enter():
	Character.is_aiming = true

func on_exit():
	Character.is_aiming = false

func state_process(delta):
	Character.stamina = Character.stamina - stamina_consumption
	if Character.stamina <= 0:
		Next_State = ground_state
	if !Character.is_on_floor():
		Next_State = air_state

func State_input(event :InputEvent):
	if event.is_action_released("Aim"):
		Next_State = ground_state
#	if event.is_action_pressed("Shoot"):
#		Next_State = shooting_state
