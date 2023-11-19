extends Node2D
class_name GunComponent

@export var weapon_behavior: WeaponBehavior
@export var weapon_host: CharacterBody2D

@export var can_shoot: bool = true
@export var can_reload: bool = true

@export var ammo_in_clip: int
@export var ammo_types: Dictionary = {
	"light": 0,
	"heavy": 0,
	"shotgun": 0
}

@onready var muzzle: Marker2D = $Muzzle
@onready var sprite: AnimatedSprite2D = $Sprite

func _ready() -> void:
	load_weapon(weapon_behavior)

func shoot_weapon(_delta: float):
	if ammo_in_clip > 0:
		weapon_behavior.shoot(self, muzzle.global_position, rotation, _delta)
		
		if can_shoot:
			sprite.play("shooting")
			can_shoot = false
		
	else:
		return false

func reload_weapon():
	
	if ammo_in_clip < weapon_behavior.clip_size and can_reload:
		can_reload = false
		weapon_behavior.reload(self)
		sprite.play("reload", weapon_behavior.firerate)

func load_weapon(new_weapon: WeaponBehavior):
	
	weapon_behavior = new_weapon # Loads new weapon
	ammo_in_clip = weapon_behavior.clip_size 
	
	sprite.sprite_frames = weapon_behavior.weapon_sprite
