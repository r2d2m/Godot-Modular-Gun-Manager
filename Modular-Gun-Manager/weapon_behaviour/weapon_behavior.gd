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
@export var consistent_spread: bool = false # If true, projectiles will keep equal distance when fired.
@export var spread_range: float = 0.0
@export var projectile_quantity: int = 1

@export_subgroup("Burst")
@export var burst_amount: int = 1
@export var burst_interval: float = 0.0


func shoot(_origin: Node2D, _projectile_position: Vector2, _projectile_rotation: float): 
	var spread_angle_extreme: float = spread_range / 50 / 2 # The furthest an angle can spread in each direction. The 50 is to fit with some bug in the engine.
	
	for p in projectile_quantity:
		if !consistent_spread:
			spawn_projectile(_origin, _projectile_position, _projectile_rotation + randf_range(-spread_angle_extreme, spread_angle_extreme)) # Rotates the projectile randomly
		elif consistent_spread:
			
			var adjusted_quantity: int = projectile_quantity - 1
			var projectile_deviation: float = spread_range / adjusted_quantity / 50
			
			if projectile_quantity > 1:
				spawn_projectile(_origin, _projectile_position, _projectile_rotation + -spread_angle_extreme + projectile_deviation * p) # Rotate the projectile in a pattern
			else:
				spawn_projectile(_origin, _projectile_position, _projectile_rotation)

func spawn_projectile(origin: Node2D, projectile_position: Vector2, projectile_rotation: float):
	
	var projectile_instance = projectile_scene.instantiate()
	
	if projectile_instance is Projectile:
		projectile_instance.weapon_behavior = self
	
	projectile_instance.global_position = projectile_position
	projectile_instance.rotation = projectile_rotation
	
	origin.get_tree().root.add_child(projectile_instance)
