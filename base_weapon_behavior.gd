@tool
extends Resource
class_name WeaponBehavior

@export_category("General Settings")
@export var name: String
@export var ammo_type: String

@export_category("Weapon Settings")
@export var weapon_sprite: SpriteFrames
@export var firerate: float
@export var clip_size: int
@export var reload_time: int
@export var recoil: float

@export_category("Projectile Settings")
@export var projectile: PackedScene = preload("res://scenes/game_objects/projectiles/projectile.tscn") # The default projectile in the project, varies per project, so will have to be changed
@export var projectile_sprite: SpriteFrames
@export var projectile_scale: float = 1.0
@export var projectile_speed: float = 75000.0

@export_category("Damage Settings")
@export var attack_instance: AttackInstance

var can_shoot: bool = true

func shoot(origin: GunComponent, projectile_position: Vector2, projectile_rotation: float, _delta: float): # Call this method to perfom shooting
	if can_shoot:
		can_shoot = false
		
		behavior_shooting_method(origin, projectile_position, projectile_rotation)
		
		# Apply Recoil
		origin.weapon_host.velocity += Vector2(-recoil, 0).rotated(projectile_rotation) * _delta
		origin.weapon_host.move_and_slide()
		
		# Take Ammo
		origin.ammo_in_clip -= 1
		
		
		await origin.get_tree().create_timer(firerate).timeout # Firerate
		
		can_shoot = true
		origin.can_shoot = true

func reload(origin: GunComponent): # Call this method for weapon reload
	
	if origin.ammo_types[self.ammo_type] <= 0: # If no ammo left
		return false
	
	origin.can_shoot = false
	origin.can_reload = false
	
	await origin.get_tree().create_timer(reload_time).timeout
	
	origin.ammo_types[self.ammo_type] += origin.ammo_in_clip
	origin.ammo_in_clip = 0 # Empty existing clip
	
	
	if origin.ammo_types[self.ammo_type] >= clip_size: # If weapon can be fully loaded
		origin.ammo_types[self.ammo_type] -= clip_size
		origin.ammo_in_clip = clip_size
		
	elif origin.ammo_types[self.ammo_type] < clip_size and origin.ammo_types[self.ammo_type] > 0: # It weapon can be partially loaded
		origin.ammo_in_clip = origin.ammo_types[self.ammo_type]
		origin.ammo_types[self.ammo_type] = 0
	
	origin.can_shoot = true
	origin.can_reload = true
	
	return true




func spawn_projectile(origin: GunComponent, projectile_position: Vector2, projectile_rotation: float):
	
	var projectile_instance = projectile.instantiate()
	
	projectile_instance.weapon_behavior = self
	projectile_instance.global_position = projectile_position
	projectile_instance.rotation = projectile_rotation
	
	##########################
	
	# This code is used to set the collision layers of the projectile, the way this is done varies
	# by project to project, so it will have to be changed
	
	
	if origin.weapon_host is PlayerCharacter: # Set player character to the class name of your character
		projectile_instance.player_owned = true # Set to method of discovering projectile ownership
	else:
		projectile_instance.player_owned = false 
	
	#########################
	
	origin.get_tree().root.add_child(projectile_instance)

func behavior_shooting_method(_origin: GunComponent, _projectile_position: Vector2, _projectile_rotation: float): 
	
	# Enter what different gun types do here, in a seperate script.
	
	pass
