# Godot-Modular-Weapon-Manager
A modular tool for easily adding weapons to a game

# How to use:

1. Bring all three files into your Godot 4 project, they don't have to be in the same folder.

2. Create a new script that inherits from the WeaponBehavior, and write code how you want this weapon type to work.

3. Create a resource from the new weapon type, and modify the weapon stats to your fit.

4. Add the gun component to a CharacterBody2D, and attach a WeaponBehavior resource to the component.

5. Hook up the component to the CharacterBody2D through code.

# Documentation

WeaponBehavior Methods:
_______________

behavior_shooting_method(_origin: GunComponent, _projectile_position: Vector2, _projectile_rotation: float):
Code left blank by default, but called during shoot(), fill with how you want a weapon type to work

_______________

shoot(origin: GunComponent, projectile_position: Vector2, projectile_rotation: float, _delta: float):
Call when you want to shoot a weapon (Called by GunComponent shoot_weapon)

______________

reload(origin: GunComponent):
Call when you want to reload a weapon (Called by GunComponent reload_weapon)

_______________

spawn_projectile(origin: GunComponent, projectile_position: Vector2, projectile_rotation: float):
Spawns a projectile at the specified location and rotation

______________
______________


GunComponent Methods:

______________

load_weapon(weapon_behavior):
Loads new WeaponBehavior and replaces the existing one

______________

shoot_weapon(_delta: float):
Calls shoot() on existing WeaponBehavior

______________

reload_weapon():
Calls reload() on existing WeaponBehavior
