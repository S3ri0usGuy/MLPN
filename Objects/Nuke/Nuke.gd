extends RigidBody2D

class_name Nuke

@onready var player :PlayerCharacter = get_node("../Player")
@onready var NSpot :Marker2D = get_node("../Player/NSpot")

@onready var label :Label = $Label
@onready var timer :Timer = $Timer
@export var pick_box :Area2D
@export var time_switch :float = 61

var is_held :bool = false
var shown_timer
var test
var facing_right : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	#starts nuke timer
	timer.start(time_switch)
	#print(shown_timer)
	player.connect("Facing_Direction_Changed",_On_Player_Facing_Direction_Changed)
	
func _physics_process(delta):
	#label.text = (str(timer.get_time_left()))
	#nuke timer display 
	shown_timer =  str(timer.get_time_left())
	shown_timer = shown_timer.split(".")
	#print(shown_timer[0])
	label.text = shown_timer[0]
	
	#detonates on timer end
	if timer.is_stopped():
		label.text = ("ko")
#		#print(get_node("../"))
#		#print(get_node("../").get_children())
#		for body in get_node("../").get_children():
#	#		print(body.name)
#	#		print(body.get_class())
#			if body.is_class("CharacterBody2D") and body.has_method("take_damage"):
#				#print(body.name)
#				#print(body.max_health)
#				body.take_damage(body.max_health)
#				print("Yey")
		
		#queue_free()
	if is_held == true:
		self.position =NSpot.global_position
#		self.lock_rotation = true
	
	#resets timer
#	if Input.is_action_just_pressed("Reset") and is_held:
#		if await(key_held("Reset")):
#			timer.start()

func _input(_event):
	if Input.is_action_just_pressed("Interact"):
		var bodies = pick_box.get_overlapping_bodies()
		for body in bodies:
			#print(body.name)
			if body.name == "Player" and player.can_hold == true:
				is_held = true
				player.can_hold = false
				#print("yo1")
				await(get_tree().create_timer(0.2).timeout)
			if Input.is_action_just_pressed("Interact"):
				#print("yo3")
				is_held = false
#				self.lock_rotation = false
				player.can_hold = true
				if !facing_right:
					apply_impulse(Vector2(), Vector2(5,-5))
					#print("yo4")
				else: 
					apply_impulse(Vector2(), Vector2(5,5))
					#print("yo4") 
	if Input.is_action_just_pressed("Reset") and is_held:
		if await(key_held("Reset")):
			timer.start()

func key_held(key :String):
	if !Input.is_action_pressed(key):
		return false
	#print("held2")
	await(get_tree().create_timer(5).timeout)
	#print("held3")
	if !Input.is_action_pressed(key):
		return false
	#print("held4")	
	return true
		

func _On_Player_Facing_Direction_Changed(Facing_Right:bool):
	if(Facing_Right):
		facing_right = true
	else :
		facing_right = false


func _on_timer_timeout():
	label.text = ("ko")
	#print(get_node("../"))
	#print(get_node("../").get_children())
	for body in get_node("../").get_children():
#		print(body.name)
#		print(body.get_class())
		if body.is_class("CharacterBody2D") and body.has_method("take_damage"):
			#print(body.name)
			#print(body.max_health)
			body.take_damage(body.max_health)
			#print("Yey")
