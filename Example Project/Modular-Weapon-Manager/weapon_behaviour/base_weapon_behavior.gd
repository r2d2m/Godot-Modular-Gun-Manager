@tool
extends Resource
class_name WeaponBehavior

@export_category("Base Weapon Settings")

@export_group("General")
@export var weapon_name: String
@export var firerate: float = 1.0
@export var recoil: float
@export var attack_instance: AttackInstance

@export_group("Ammo")
@export var ammo_type: String
@export var clip_size: int
@export var reload_time: float

@export_group("Projectile")
@export var projectile_scene: PackedScene
@export var projectile_scale: float = 1.0
@export var projectile_speed: float = 75000.0
@export var projectile_range: float = 100000.0

@export_group("Advanced Settings")

@export_subgroup("Projectile Spread")
@export var consistent_spread: bool = false
@export var spread_range: float = 0.0
@export var projectile_quantity: int = 1

func shoot(_origin: Node2D, _projectile_position: Vector2, _projectile_rotation: float): 
	var spread_angle_extreme: float = spread_range / 50 / 2 # The furthest an angle can spread in each direction.
	
	for p in projectile_quantity:
		if !consistent_spread:
			spawn_projectile(_origin, _projectile_position, _projectile_rotation + randf_range(-spread_angle_extreme, spread_angle_extreme))
		elif consistent_spread:
			
			var adjusted_quantity: int = projectile_quantity - 1
			var projectile_deviation: float = spread_range / adjusted_quantity / 50
			
			if projectile_quantity > 1:
				spawn_projectile(_origin, _projectile_position, _projectile_rotation + -spread_angle_extreme + projectile_deviation * p)
			else:
				spawn_projectile(_origin, _projectile_position, _projectile_rotation)


func get_reload_info(ammo_in_clip: int, max_ammo_in_clip: int, ammo_stocked: int): # Calls to get specifications of weapon reload
	
	var ammo_pool = ammo_stocked + ammo_in_clip # Combines all ammo together.
	
	if ammo_stocked <= 0 or ammo_in_clip >= max_ammo_in_clip: # If no more ammo left OR clip already full (So no reload
		return {"can_reload": false, "ammo_in_clip": ammo_in_clip, "ammo_stocked": ammo_stocked}
		
	elif ammo_pool >= max_ammo_in_clip: # Full reload
		return {"can_reload": true, "ammo_in_clip": max_ammo_in_clip, "ammo_stocked": ammo_pool - max_ammo_in_clip}
		
	elif ammo_pool >= 1 and ammo_pool < max_ammo_in_clip: # Partial reload
		return {"can_reload": true, "ammo_in_clip": ammo_pool, "ammo_stocked": 0}
		
	else: # Error or unexpected situation, keep as is.
		return {"can_reload": false, "ammo_in_clip": ammo_in_clip, "ammo_stocked": ammo_stocked}


func spawn_projectile(origin: Node2D, projectile_position: Vector2, projectile_rotation: float):
	
	var projectile_instance = projectile_scene.instantiate()
	
	if projectile_instance is Projectile:
		projectile_instance.weapon_behavior = self
	
	projectile_instance.global_position = projectile_position
	projectile_instance.rotation = projectile_rotation
	
	origin.get_tree().root.add_child(projectile_instance)
