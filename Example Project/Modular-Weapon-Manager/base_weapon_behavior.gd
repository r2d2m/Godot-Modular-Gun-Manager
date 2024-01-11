@tool
extends Resource
class_name WeaponBehavior

@export_category("General Settings")
@export var weapon_name: String
@export var ammo_type: String

@export_category("Weapon Specifications")
@export var firerate: float = 1.0
@export var clip_size: int
@export var reload_time: float
@export var recoil: float

@export_category("Projectile Specifications")
@export var projectile_scene: PackedScene
@export var projectile_scale: float = 1.0
@export var projectile_speed: float = 75000

@export_category("Damage Specifications")
@export var attack_instance: AttackInstance



func custom_shoot():
	
	# When creating a gun type, enter how the firing logic (Like spread for a shotgun) in this function.
	
	pass

func custom_shoot_failed():
	
	# Calls when shooting lacks ammunition
	
	pass

func custom_reload_begin():
	
	# Calls at the beginning of a reload
	
	pass

func custom_reload_end():
	
	# Calls at the end of a reload
	
	pass

func custom_reload_failed():
	
	# Calls when reload lacks ammunition
	
	pass

func custom_destroy_weapon():
	
	# Calls before destroying an old weapon
	
	pass

func custom_load_weapon():
	
	# Calls after loading a new weapon 
	
	pass






func shoot(_origin: Node2D, _projectile_position: Vector2, _projectile_rotation: float): 
	custom_shoot()

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
	
	projectile_instance.weapon_behavior = self
	projectile_instance.global_position = projectile_position
	projectile_instance.rotation = projectile_rotation
	
	origin.get_tree().root.add_child(projectile_instance)
