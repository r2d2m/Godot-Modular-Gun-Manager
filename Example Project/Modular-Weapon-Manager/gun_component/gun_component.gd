extends Node2D
class_name GunComponent2D

@export_category("General Settings")
@export var weapon_behavior: WeaponBehavior
@export var weapon_host: Node2D # The node taht uses the component (Ex: The Player Character)
@export var muzzle_position: Vector2

@export_category("Active Settings") # These are meant to be controlled by others nodes in the scene (Like the main game script)
@export var can_shoot: bool = true
@export var can_reload: bool = true

@export_category("Ammunition Settings")
@export var use_ammo: bool = true
@export var ammo_in_clip: int
@export var stored_ammo_types: Dictionary = {
	# Add the ammo types you wish to use, all values must be intergers
}


func custom_shoot():
	
	# Calls on shoot
	
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

func custom_ready():
	
	# Calls on ready
	
	pass

func custom_process(_delta: float):
	
	# Calls every frame
	
	pass




# Shooting

var is_shooting: bool = false # Controlled internally, do not override

func _ready() -> void:
	
	custom_ready()
	
	if weapon_behavior: # Loads initial weapon
		load_weapon(weapon_behavior)

func _process(_delta: float) -> void:
	custom_process(_delta)

func shoot_weapon():
	
	if weapon_behavior and weapon_host and can_shoot and !is_shooting and !is_reloading: # Check if shoot is possible
		
		if ammo_in_clip > 0 or !use_ammo: # Check ammunition
			
			if use_ammo: # Remove Ammo
				ammo_in_clip -= 1
			
			is_shooting = true
			
			weapon_behavior.shoot(self, muzzle_position, global_rotation)
			custom_shoot()
			
			await get_tree().create_timer(weapon_behavior.firerate).timeout
			if is_shooting:
				is_shooting = false
			
		else: # Not enough ammunition to shoot
			
			custom_shoot_failed()
			weapon_behavior.custom_shoot_failed()
			


# Reloading

var is_reloading: bool = false

func reload_weapon():
	if weapon_behavior and weapon_host and use_ammo and can_reload and !is_shooting and !is_reloading: # Checks if reload is currently allowed
		
		var reload_info: Dictionary = weapon_behavior.get_reload_info(ammo_in_clip, weapon_behavior.clip_size, stored_ammo_types[weapon_behavior.ammo_type])
		
		if reload_info["can_reload"] and stored_ammo_types.has(weapon_behavior.ammo_type) or !use_ammo: # Checks if component has sufficient ammunition
			
			is_reloading = true
			
			custom_reload_begin()
			weapon_behavior.custom_reload_begin()
			await get_tree().create_timer(weapon_behavior.reload_time).timeout
			_on_reload_timer_timeout()
			
		else: # Fails reload in not enough ammunition
			
			weapon_behavior.custom_reload_failed()
			custom_reload_failed()

func _on_reload_timer_timeout() -> void:
	if is_reloading: # Finish the reload
		var reload_info: Dictionary = weapon_behavior.get_reload_info(ammo_in_clip, weapon_behavior.clip_size, stored_ammo_types[weapon_behavior.ammo_type])
		
		ammo_in_clip = reload_info["ammo_in_clip"]
		stored_ammo_types[weapon_behavior.ammo_type] = reload_info["ammo_stocked"]
		
		custom_reload_end()
		weapon_behavior.custom_reload_end()
		
		is_reloading = false


# Weapon Loading

func load_weapon(new_weapon: WeaponBehavior):
	custom_destroy_weapon()
	weapon_behavior = new_weapon
	
	ammo_in_clip = weapon_behavior.clip_size
	
	is_shooting = false
	is_reloading = false
	
	custom_load_weapon()
