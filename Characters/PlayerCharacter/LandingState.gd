extends State

@export var Landing_Animation_Name :String = "Jump_end"
@export var ground_state : State

@onready var timer : Timer = $Timer

func on_enter():
	timer.start(0.5)

#func _on_animation_tree_animation_finished(anim_name):
#	if(anim_name == Landing_Animation_Name):
#		Next_State = Ground_State

func _on_timer_timeout():
	Next_State = ground_state
