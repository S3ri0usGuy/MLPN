extends State

class_name AirState

@export var Landing_State :State
#@export var Double_Jump_Velocity : float = -75.0
#@export var Double_Jump_Animation : String = "Double_Jump"
@export var Landing_Animation : String = "Jump_end"
#var Has_Double_Jumped : bool = false

func state_process(delta): 
	if(Character.is_on_floor()):
		Next_State = Landing_State

#func State_input(event :InputEvent):
#	if (event.is_action_pressed("Jump") and !Has_Double_Jumped):
#		Double_Jump() 

func on_exit():
	if(Next_State == Landing_State):
		pass
		#Playback.travel(Landing_Animation)
		#Has_Double_Jumped = false

#func Double_Jump():
#	Character.velocity.y = Double_Jump_Velocity
#	#Playback.travel(Double_Jump_Animation)
#	Has_Double_Jumped = true
