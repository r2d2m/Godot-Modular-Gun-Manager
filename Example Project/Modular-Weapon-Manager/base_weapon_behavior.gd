@tool
extends Resource
class_name WeaponBehavior

@export_category("General Settings")
@export var weapon_name: String
@export var weapon_type: String
@export var ammo_type: String

@export_category("Visuals")
@export var weapon_sprite: SpriteFrames

@export_category("Weapon Specifications")
@export var firerate: float = 1.0
@export var clip_size: int
@export var reload_time: float
@export var recoil: float

@export_category("Projectile Specifications")
@export var projectile_scene: PackedScene
@export var projectile_sprite: SpriteFrames
@export var projectile_scale: float = 1.0
@export var projectile_speed: float = 75000
@export var projectile_lifespan: float = 10.0

@export_category("Damage Specifications")
@export var attack_instance: AttackInstance

@export_category("Sparks")
@export var sparks_enabled: bool = true
@export var spark_color: Color = Color(0.988, 0.749, 0.333)
@export var spark_sprite: Texture

var can_shoot: bool = true

func behavior_shooting_method(_origin: GunComponent, _projectile_position: Vector2, _projectile_rotation: float): 
	
	# When creating a gun type, enter how the firing logic (Like spread for a shotgun) in this function.
	
	pass



func shoot(origin: GunComponent, projectile_position: Vector2, projectile_rotation: float, _delta: float): # Call this method to perfom shooting
	if can_shoot:
		can_shoot = false
		
		behavior_shooting_method(origin, projectile_position, projectile_rotation)
		
		# Apply Recoil
		if origin.weapon_host is CharacterBody2D:
			origin.weapon_host.velocity += Vector2(-recoil, 0).rotated(projectile_rotation) * _delta
		
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
		
	elif origin.ammo_types[self.ammo_type] < clip_size and origin.ammo_types[self.ammo_type] > 0: # If weapon can be partially loaded
		origin.ammo_in_clip = origin.ammo_types[self.ammo_type]
		origin.ammo_types[self.ammo_type] = 0
	
	origin.can_shoot = true
	origin.can_reload = true
	
	return true




func spawn_projectile(origin: GunComponent, projectile_position: Vector2, projectile_rotation: float):
	
	var projectile_instance = projectile_scene.instantiate()
	
	projectile_instance.weapon_behavior = self
	projectile_instance.global_position = projectile_position
	projectile_instance.rotation = projectile_rotation
	
	origin.get_tree().root.add_child(projectile_instance)
