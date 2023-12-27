extends Node2D

func _process(_delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		$CharacterBody2D/Hip/GunComponent.shoot_weapon(_delta)
	if Input.is_action_just_pressed("reload"):
		$CharacterBody2D/Hip/GunComponent.reload_weapon()
	$CharacterBody2D/Hip.look_at(get_global_mouse_position())
	
	if $CharacterBody2D/Hip.rotation > 90:
		$CharacterBody2D/Hip/GunComponent/Gun/Sprite.flip_v = true
	else:
		$CharacterBody2D/Hip/GunComponent/Gun/Sprite.flip_v = false

func _physics_process(_delta: float) -> void:
	$CharacterBody2D.move_and_slide()
