extends State

@export var character :Enemy
@export var follow_state :State

var move_direction :Vector2
var wonder_time :float
var player :PlayerCharacter

func _ready():
	player = get_tree().get_first_node_in_group('Player')

func randomise_wander():
	move_direction = Vector2(randf_range(-1,1),0).normalized()
	wonder_time = randf_range(1,3)

func on_enter():
	print('enter idle')
	player = get_tree().get_first_node_in_group('Player')
	randomise_wander()

func state_update(delta):
	if wonder_time > 0:
		wonder_time = wonder_time - delta
	else:
		randomise_wander()

func state_process(delta): 
	if Character:
		Character.velocity = move_direction * Character.SPEED
	
	var direction = player.global_position - Character.global_position
	if direction.length() <= (Character.awerness / 2):
		#await(get_tree().create_timer(1.5).timeout)
		Next_State = follow_state
