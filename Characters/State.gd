extends Node

class_name State

@export var Can_Move :bool = true 
@export var can_sprint : bool = true
@export var can_shoot :bool = true

var Character : CharacterBody2D
var Next_State : State = null
#var Playback : AnimationNodeStateMachinePlayback 

signal Interrupt_State(New_State : State)

func state_update(delta): #process update
	pass

func state_process(delta):#phisics process update
	pass

func State_input(event :InputEvent):
	pass

func on_enter():
	pass

func on_exit():
	
	pass
