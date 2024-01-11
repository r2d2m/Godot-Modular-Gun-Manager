extends Node2D
class_name GunComponent2D

@export_category("General Settings")
@export var weapon_behavior: WeaponBehavior
@export var weapon_host: Node2D # The node taht uses the component (Ex: The Player Character)
@export var muzzle_position: Vector2

@export_category("Active Settings")
@export var can_shoot: bool = true
@export var can_reload: bool = true

@export_category("Ammunition Settings")
@export var use_ammo: bool = true
@export var ammo_in_clip: int
@export var stored_ammo_types: Dictionary = {
	# Add the ammo types you wish to use, all values must be intergers
}

@onready var ReloadTimer: Timer = $ReloadTimer
@onready var FirerateTimer: Timer = $FirerateTimer



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





# Shooting

var is_shooting: bool = false

func shoot_weapon():
	if weapon_behavior and weapon_host and can_shoot and !is_shooting and !is_reloading:
		
		if ammo_in_clip > 0 or !use_ammo:
			if use_ammo:
				ammo_in_clip -= 1
			
			is_shooting = true
			
			weapon_behavior.shoot(self, muzzle_position, global_rotation)
			custom_shoot()
			
			FirerateTimer.start(weapon_behavior.firerate)
			
		else: # Not enough ammunition to shoot
			
			custom_shoot_failed()
			weapon_behavior.custom_shoot_failed()
			

func _on_firerate_timer_timeout() -> void:
	if is_shooting:
		is_shooting = false


# Reloading

var is_reloading: bool = false

func reload_weapon():
	if weapon_behavior and weapon_host and use_ammo and can_reload and !is_shooting and !is_reloading: # Checks if reload is currently allowed
		
		var reload_info: Dictionary = weapon_behavior.get_reload_info(ammo_in_clip, weapon_behavior.clip_size, stored_ammo_types[weapon_behavior.ammo_type])
		
		if reload_info["can_reload"] and stored_ammo_types.has(weapon_behavior.ammo_type) or !use_ammo: # Checks if component has sufficient ammunition
			
			is_reloading = true
			
			custom_reload_begin()
			weapon_behavior.custom_reload_begin()
			ReloadTimer.start(weapon_behavior.reload_time)
			
		else: # Fails reload in not enough ammunition
			
			custom_reload_failed()
			weapon_behavior.custom_reload_failed()
			

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
	
	is_shooting = false
	is_reloading = false
	
	FirerateTimer.stop()
	ReloadTimer.stop()
	
	custom_load_weapon()
