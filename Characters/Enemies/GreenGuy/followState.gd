extends State
@export var idle_state :State
@export var attacking_state :State
@export var character :Enemy

var player :PlayerCharacter


func on_enter():
	print('enter following')
	player = get_tree().get_first_node_in_group('Player')
	#print(player)

func state_process(delta):
	player = get_tree().get_first_node_in_group('Player')
	var direction = player.global_position - Character.global_position
	#print(direction.length())
	if direction.length() <= Character.awerness:
		Character.velocity = direction.normalized() * Character.SPEED
	else:
		Character.velocity = Vector2()
	if direction.length() <= 30:
		print("attack")
		Next_State = attacking_state
	
	if direction.length() > Character.awerness:
		Next_State = idle_state
