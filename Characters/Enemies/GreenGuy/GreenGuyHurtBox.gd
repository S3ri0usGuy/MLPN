extends  HurtBox

func _init() -> void:
	collision_layer = 0
	collision_mask = 4

func  _ready():
	self.area_entered.connect(_on_area_entered)
	
func _on_area_entered(hitbox : HitBox):
	if hitbox == null:
		return
	
	#print("debil")
	print(owner)
	if owner.has_method("take_damage"):
		print("yas")
		#print(hitbox.damage)
		owner.take_damage(hitbox.damage)
