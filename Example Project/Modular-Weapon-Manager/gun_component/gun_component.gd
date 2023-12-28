extends Node2D
class_name GunComponent

@export var weapon_behavior: WeaponBehavior
@export var weapon_host: Node2D # The node taht uses the component (Ex: The Player Character)

@export var can_shoot: bool = true
@export var can_reload: bool = true

@export var ammo_in_clip: int
@export var ammo_types: Dictionary = {
	"light": 0,
	"heavy": 0,
	"shotgun": 0
	# Add the ammo types you wish to use
}

@onready var muzzle: Marker2D = $Gun/Muzzle
@onready var particles: GPUParticles2D = $Gun/Muzzle/GPUParticles2D
@onready var sprite: AnimatedSprite2D = $Gun/Sprite
@onready var animator: AnimationPlayer = $AnimationPlayer

@onready var up_point: Marker2D = $UpPoint

func _ready() -> void:
	load_weapon(weapon_behavior)

func shoot_weapon(_delta: float):
	if ammo_in_clip > 0:
		weapon_behavior.shoot(self, muzzle.global_position, global_rotation, _delta)
		
		if can_shoot:
			can_shoot = false
			animator.stop()
			particles.restart()
			animator.play("fire")

func reload_weapon():
	if ammo_in_clip < weapon_behavior.clip_size and can_reload:
		
		can_reload = false
		weapon_behavior.reload(self)
		
		particles.restart()
		animator.stop()
		animator.play("reload_start")
		await get_tree().create_timer(weapon_behavior.reload_time - 0.4).timeout
		animator.play("reload_end")

func load_weapon(new_weapon: WeaponBehavior):
	
	weapon_behavior = new_weapon # Loads new weapon
	ammo_in_clip = weapon_behavior.clip_size 
	
	sprite.sprite_frames = weapon_behavior.weapon_sprite
	
	particles.texture = weapon_behavior.spark_sprite
	particles.visible = weapon_behavior.sparks_enabled
	particles.modulate = weapon_behavior.spark_color
	
	muzzle.position.x = sprite.sprite_frames.get_frame_texture("default", 0).get_width() * 3 # Adjusts the muzzle to the end of the sprite

func _process(delta: float) -> void:
	if up_point.global_position.y - global_position.y < 0:
		sprite.flip_v = false
	else:
		sprite.flip_v = true
