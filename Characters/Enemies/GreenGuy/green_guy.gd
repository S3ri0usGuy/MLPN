extends Enemy

@onready var State_Machine :CharacterStateMachine = $CharacterStateMachine


@export var SPEED = 25
@export var max_health :float = 100
@export var health :float = 100
@export var awerness :float = 100

@export var sprite :Sprite2D
#@export var Starting_Move_Direction : Vector2 = Vector2.LEFT
@export var Hit_State : State

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

signal Facing_Direction_Changed(facing_right :bool)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	var direction = self.velocity
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
#	var direction = Input.get_axis("ui_left", "ui_right")
#	if direction:
#		velocity.x = direction * SPEED
#	else:
#		velocity.x = move_toward(velocity.x, 0, SPEED)
	
#	var direction : Vector2 = Starting_Move_Direction
#	if direction && State_Machine.Check_If_Can_Move():
#		velocity.x = direction.x * SPEED
#	elif(State_Machine.Current_State != Hit_State):
#		velocity.x = move_toward(velocity.x, 0, SPEED)
	if State_Machine.Check_If_Can_Move():
		move_and_slide()
	Update_Facing_Direction()

func Update_Facing_Direction():
	if velocity.x > 0 and get_global_mouse_position().x > position.x:
		sprite.flip_h = false
	elif velocity.x < 0 and  get_global_mouse_position().x < position.x:
		sprite.flip_h = true 
	emit_signal("Facing_Direction_Changed", sprite.flip_h)

func take_damage(amount :float):
	print("Enemy taken damage: " + str(amount))
	health = health - amount
	if health <= 0:
		queue_free()
