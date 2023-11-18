@tool
extends Resource
class_name WeaponBehavior

@export_category("General Settings")
@export var name: String
@export var ammo_type: String

@export_category("Gun Settings")
@export var gun_sprite: SpriteFrames
@export var firerate: float
@export var clip_size: int
@export var reload_time: int
@export var recoil: float

@export_category("Projectile Settings")
@export var projectile_sprite: SpriteFrames
@export var projectile_scale: float = 1.0
@export var projectile_speed: float = 75000.0

@export_category("Damage Settings")
@export var attack_instance: AttackInstance



var projectile = preload("res://scenes/game_objects/projectiles/projectile.tscn")
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

func reload(origin: GunComponent): # Call this method for weapon reload
	
	origin.ammo_types[self.ammo_type] += origin.ammo_in_clip
	origin.ammo_in_clip = 0 # Empty existing clip
	
	
	if origin.ammo_types[self.ammo_type] >= clip_size: # If weapon can be fully loaded
		origin.ammo_types[self.ammo_type] -= clip_size
		origin.ammo_in_clip = clip_size
		return true
		
	elif origin.ammo_types[self.ammo_type] < clip_size and origin.ammo_types[self.ammo_type] > 0: # It weapon can be partially loaded
		origin.ammo_in_clip = origin.ammo_types[self.ammo_type]
		origin.ammo_types[self.ammo_type] = 0
		return true
	
	else: # If no ammo left
		return false



func spawn_projectile(origin: GunComponent, projectile_position: Vector2, projectile_rotation: float):
	
	var projectile_instance = projectile.instantiate()
	
	projectile_instance.weapon_behavior = self
	projectile_instance.global_position = projectile_position
	projectile_instance.rotation = projectile_rotation
	
	origin.get_tree().root.add_child(projectile_instance)
	
	if origin.weapon_host is PlayerCharacter:
		projectile_instance.player_owned = true
	else:
		projectile_instance.player_owned = false

func behavior_shooting_method(_origin: GunComponent, _projectile_position: Vector2, _projectile_rotation: float): 
	
	# Enter what different gun types do here, in a seperate script.
	
	pass
