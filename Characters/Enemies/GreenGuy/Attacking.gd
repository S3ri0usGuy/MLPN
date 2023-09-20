extends State
@export var collision_shape :FacingCollisionShape2D
@export var following_state :State

@export var attack_speed :float = 0.75

@onready var timer :Timer = $Timer

func on_enter():
	print('enter attacking')
	collision_shape.disabled = false
	timer.start(attack_speed)

func on_exit():
	collision_shape.disabled = true

func _on_timer_timeout():
	Next_State = following_state # Replace with function body.
