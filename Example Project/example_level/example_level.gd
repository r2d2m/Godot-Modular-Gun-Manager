extends Node2D

@onready var hip: Node2D = $CharacterBody2D/Hip
@onready var gun: TopDownGunComponent2D = $CharacterBody2D/Hip/TopDownGun2D

func _process(delta: float) -> void:
	hip.look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("shoot"):
		gun.shoot_weapon()
	elif Input.is_action_just_pressed("reload"):
		gun.reload_weapon()
	
