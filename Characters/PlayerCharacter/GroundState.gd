extends State
class_name Ground_State

@export var player :PlayerCharacter
@export var Jump_Velocity : float = -150.0
@export var State_Machine :CharacterStateMachine
@export var Air_State : State
@export var ground_state :State	
#@export var Jump_Animation : String = "Jump_start"
#@export var Attack_Animation : String = "Attack_1"
@export var Meele_State :State
@export var Shooting_State :State
@export var Sprint_State :State
@export var Aim_State :State
@export var stamina_regen :float = 0.5
@export var jump_stamina_consumption :float = 50.0

func state_process(delta): 
	if(!Character.is_on_floor()):
		Next_State = Air_State
	#stamina regen code 
	if( player.stamina != 1000 and player.stamina <= 1000 ): #State_Machine.Current_State == ground_state and
		#await(get_tree().create_timer(5).timeout)
		if(!player.can_hold):
			player.stamina = player.stamina + (stamina_regen/2)#zmień to jak tylko będziesz mógł bo będą problemy
			if player.stamina > 1000:
				player.stamina = 1000
		else:
			player.stamina = player.stamina + stamina_regen
			if player.stamina > 1000:
				player.stamina = 1000
#velocity.y = Jump_Velocity
func State_input(event :InputEvent):
	if(event.is_action_pressed("Jump")and player.stamina >= 0):
		Jump()
	if (event.is_action_pressed("Attack") and player.stamina >= 0):
		Meele()
#	if(event.is_action_pressed("Shoot")):
#		Shoot()
	if (event.is_action_pressed("Sprint") and can_sprint and player.stamina >= 0):
		Sprint()
	if (event.is_action_pressed("Aim")):
		Aim()

func Jump():
	Character.velocity.y = Jump_Velocity /player.carring
	if !player.can_hold:
		player.stamina = player.stamina - (jump_stamina_consumption*2)
		Next_State = Air_State
	else:
		player.stamina = player.stamina - jump_stamina_consumption
		Next_State = Air_State
	#Playback.travel(Jump_Animation)
	
func Meele():
	Next_State = Meele_State
	#Playback.travel(Attack_Animation)

func Shoot():
	Next_State = Shooting_State

func Sprint():
	Next_State = Sprint_State

func Aim():
	Next_State = Aim_State
