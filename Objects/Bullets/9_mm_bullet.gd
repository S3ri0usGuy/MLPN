extends Node2D


@export var speed :float = 1000.0
@export var lifetime = 1
@export var cycle_time = 0.25

var direction :Vector2 = Vector2.ZERO

@onready var timer :Timer = $Timer
@onready var hitbox :HitBox = $BulletHitbox
@onready var sprite :Sprite2D = $Sprite2D
@onready var impact_detector :Area2D = $ImpactDetector

# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_top_level(true)
	look_at(position + direction)
	#timer.connect("timeout", self, "queue_free")
	#timer.timeout.connect(_on_impact(self))
	#timer.start(3)
	#impact_detector.connect("body_entered", self, "_on_impact")
	impact_detector.body_entered.connect(_on_impact)
	#mam nadzieje że linijki 19 i 22 zadziałają bo jak nie to chuj

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += direction * speed * delta
	await(get_tree().create_timer(lifetime).timeout)
	print("despawn")
	queue_free()
	#if timer.is_stopped():
		#print("nie")
		#queue_free()

func _on_impact(body :Node):
	print(body)
	queue_free()
