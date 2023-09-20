extends Node

class_name CharacterStateMachine

@export var Current_State :State
@export var Animation_Tree :AnimationTree
@export var Character :CharacterBody2D
@export var Previous_State :State = null
var states :Array[State]

func _ready():
	for child in get_children():
		if (child is State):
			states.append(child)
			
			child.Character = Character
			#child.Playback = Animation_Tree["parameters/playback"]
			
			child.connect("Interrupt_State", On_State_Interrupt_State)
		else:
			push_warning("child: " + child.name + " is not a state for character state machine")

func _process(delta):
	Current_State.state_update(delta)

func _physics_process(delta):
	if(Current_State.Next_State != null):
		Switch_States(Current_State.Next_State)
		
	Current_State.state_process(delta)

func Check_If_Can_Move():
	return Current_State.Can_Move

func Check_If_Can_Sprint():
	return Current_State.can_sprint

func Check_If_Can_Shoot():
	return Current_State.can_shoot

func Switch_States(New_State :State):
	if(Current_State != null):
		Current_State.on_exit()
		Current_State.Next_State = null
	
	if Previous_State != Current_State:
		Previous_State = Current_State
	
	Current_State = New_State
	
	Current_State.on_enter()

func _input(event : InputEvent):
	Current_State.State_input(event)
	
func On_State_Interrupt_State(New_State : State):
	Switch_States(New_State)
