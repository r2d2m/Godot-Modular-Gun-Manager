extends GunComponent2D
class_name TopDownGunComponent2D

@onready var muzzle: Marker2D = $Gun/Muzzle
@onready var particles: GPUParticles2D = $Gun/Muzzle/GPUParticles2D
@onready var sprite: AnimatedSprite2D = $Gun/Sprite
@onready var animator: AnimationPlayer = $AnimationPlayer

@onready var up_point: Marker2D = $UpPoint


func custom_load_weapon():
	if weapon_behavior is TopDownWeaponBehavior:
		
		if weapon_behavior.animate_sprite_actions:
			animator.play("reload_end")
		
		sprite.sprite_frames = weapon_behavior.weapon_sprite
		
		particles.texture = weapon_behavior.sparks_texture
		particles.visible = weapon_behavior.sparks_enabled
		particles.modulate = weapon_behavior.sparks_modulate
		
		muzzle.position.x = sprite.sprite_frames.get_frame_texture("default", 0).get_width() * 3 # Adjusts the muzzle to the end of the sprite


func custom_shoot():
	if weapon_behavior is TopDownWeaponBehavior:
		
		if weapon_behavior.sparks_enabled:
			particles.restart()
		
		if weapon_behavior.animate_sprite_actions:
			animator.stop()
			animator.play("fire")

func custom_reload_begin():
	animator.stop()
	animator.play("reload_start")

func custom_reload_end():
	animator.play("reload_end")

func _process(_delta: float) -> void:
	if weapon_behavior is TopDownWeaponBehavior: 
		
		 # Ensure the sprite is always facing up and away from the player
		
		if up_point.global_position.y - global_position.y < 0 and weapon_behavior.auto_flip_sprite:
			sprite.flip_v = false
		elif weapon_behavior.auto_flip_sprite:
			sprite.flip_v = true
		
		muzzle_position = muzzle.global_position
		
