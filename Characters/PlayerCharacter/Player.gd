extends CharacterBody2D

class_name PlayerCharacter

const Nine_Mm_Bullet_Scene = preload("res://Objects/Bullets/9_mm_bullet.tscn")

@export var Speed : float = 100.0
@export var push : float = 60.0
@export var can_hold :bool = true
@export var base_sprint_speed : float = 50.0
@export var sprint_speed : float = 1.0
@export var carring_modifire : float = 2.0
@export var carring : float = 1.0
@export var stamina : float = 1000
@export var max_health : float = 100.0
@export var health :float = 100.0
@export var is_aiming :bool = false
@export var weapon_id_used :int = 1

@onready var sprite :Sprite2D = $Sprite2D
#@onready var Animation_tree : AnimationTree = $AnimationTree
@onready var State_Machine : CharacterStateMachine = $PlayerStateMachine 
@onready var M92_sprite :Sprite2D = $M92
@onready var M92_sprite_shoot_position :Marker2D = $M92/shoot_position

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2.ZERO
var rand_M92_spread :float =  randf_range(0.85,1.0)

var shoot_position :Marker2D

signal Facing_Direction_Changed(facing_right :bool)

func _ready():
	if(weapon_id_used == 1):
		shoot_position = M92_sprite_shoot_position
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	if !can_hold:
		carring = carring_modifire
	else:
		carring = 1
	
	if stamina < 0: # to powinno być przy using stamina
		stamina = 0
	
	M92_sprite.look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("First_Weapon"):
		weapon_id_used = 1
		shoot_position = M92_sprite_shoot_position
	if Input.is_action_pressed("Second_Weapon"):
		weapon_id_used = 2
	if Input.is_action_just_pressed("Shoot") and State_Machine.Check_If_Can_Shoot():
		test_shoot(Nine_Mm_Bullet_Scene, shoot_position)
#		print(get_global_mouse_position())
#		print(position)
		#print(1* randf_range(0.85,1.0) )
	
	#old non state sprit handling
	#if Input.is_action_pressed("Sprint") and State_Machine.Check_If_Can_Sprint():
		#sprint_speed = base_sprint_speed
	#elif !Input.is_action_pressed("Sprint"):
		#sprint_speed = 1
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	direction = Input.get_vector("Left", "Right","Up","Down")
	
	if direction.x != 0 and State_Machine.Check_If_Can_Move() :
		velocity.x = direction.x * (Speed + sprint_speed)/carring  
	else:
		velocity.x = move_toward(velocity.x, 0, Speed)
	
#	for index in get_slide_collision_count():
#		var collision = get_slide_collision(index)
#		if collision.get_collider().is_in_group("bodies"):
#			collision.get_collider().apply_central_impulse(-collision.normal * push)
	
	move_and_slide()
	#Update_Animation()
	Update_Facing_Direction()

func test_shoot(projectile :PackedScene, shooting_position: Marker2D):
	var projectie_instance = projectile.instantiate()
	projectie_instance.position = shooting_position.global_position
	if is_aiming:
		projectie_instance.direction = global_position.direction_to(get_global_mouse_position())
		print("celuje")
	else:
		projectie_instance.direction = global_position.direction_to(get_global_mouse_position() * randf_range(0.85,1.0))
		print("no chyba nie")
	add_child(projectie_instance)

#func Update_Animation():
	#Animation_tree.set("parameters/Move/blend_position", direction.x)
#	if not Animation_Locked:
#		if direction.x != 0:
#			Animated_sprite.play("Run")
#		else:
#			Animated_sprite.play("idle")
#	if not is_on_floor() and not Animation_Locked:
#		Animated_sprite.play("Jump_loop")

func Update_Facing_Direction():
	if direction.x > 0 and get_global_mouse_position().x > position.x:
		sprite.flip_h = false
	elif direction.x < 0 and  get_global_mouse_position().x < position.x:
		sprite.flip_h = true 
	emit_signal("Facing_Direction_Changed", sprite.flip_h)

func take_damage(amount :float):
	print("Player taken damage: " + str(amount))
	health = health - amount
	if health <= 0:
		print("dead")
		player_death()
		#queue_free()

func player_death():
	Speed = 0
	await(get_tree().create_timer(2).timeout)
	get_tree().reload_current_scene()
	#queue_free()
	pass
