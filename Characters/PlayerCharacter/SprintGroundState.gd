extends State

@export var character :PlayerCharacter
@export var ground_state :State 
@export var air_state :State
@export var sprint_state :State
@export var melee_state : State
@export var aim_state :State
@export var stamina_consumption :int = 5 
@export var State_Machine : CharacterStateMachine

#var sprite_direction :bool = false
#var sprite_direction_not_changed :bool = false

#func _ready():
#	character.connect("Facing_Direction_Changed",direction_changed ) 

func on_enter():
	character.sprint_speed = character.base_sprint_speed

func on_exit():
	#inercia that I tried to do
	#for i in range(character.base_sprint_speed, 1):
	#	character.sprint_speed = i
	character.sprint_speed = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func state_process(delta):
	if(character.direction.x != 0):
		if(!character.can_hold):
			character.stamina = character.stamina - (stamina_consumption * 2) 
		else:
			character.stamina = character.stamina - stamina_consumption
	elif (character.direction.x == 0):# and sprite_direction_not_changed == true): #return to stamina regen after not moving and being in sprint state
		await (get_tree().create_timer(1).timeout)
		Next_State = ground_state
	if character.stamina <= 0:
		Next_State = ground_state
	if(!character.is_on_floor()):
		Next_State = air_state
	

func State_input(event :InputEvent):
	if(event.is_action_pressed("Sprint")):
		Next_State = ground_state
	if(event.is_action_pressed("Interact")):
		Next_State = ground_state
	if(event.is_action_pressed("Reset")):
		Next_State = ground_state
	if(event.is_action_pressed("Jump")):
		ground_state.Jump()
	if(event.is_action_pressed("Aim")):
		Next_State = aim_state
	if(event.is_action_pressed("Attack")):
		Next_State = melee_state

#I tried to fix the bug caussed by exiting sprint state while changenig directions I failed for now
#func direction_changed(facing_changed):
#	if facing_changed :
#		print("zgadza się")
#		sprite_direction_not_changed = true
#		sprite_direction = true
#	elif !facing_changed:
#		print("nie zgadza się")
#		sprite_direction_not_changed = false
#		sprite_direction = false
