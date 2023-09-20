extends State

@export var player :PlayerCharacter
@export var collision_shape :FacingCollisionShape2D
@export var ground_state :State
#@export var air_state :State
@export var stamina_cost :float = 100
@export var attack_speed :float = 0.5

@onready var timer :Timer = $Timer

func on_enter():
	collision_shape.disabled = false
	timer.start(attack_speed)
	player.stamina = player.stamina - stamina_cost

func on_exit():
	collision_shape.disabled = true

#func state_process(delta):
#	if Character.is_on_floor():
#		Next_State = air_state

func _on_timer_timeout():
	Next_State = ground_state
	
