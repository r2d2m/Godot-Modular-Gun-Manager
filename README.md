<h1> Godot-Modular-Weapon-Manager </h1>
A modular tool for easily adding weapons to a 2D game

<h1> How to use: </h1> 

1. Bring the files from "Modular-Weapon-Manager" into your Godot 4 project, they don't have to be in the same directory.

2. Create a new script that inherits from the WeaponBehavior, and write code how you want this weapon type to work.

3. Create a resource from the new weapon type, and modify the weapon stats to your fit.

4. Add the GunComponent to a 2D node (Prefferably CharacterBody2D), select the node as the GunComponent's "Weapon Host"

5. Attach a WeaponBehavior ressource to the GunComponent, and connect inputs to the GunComponent's methods. (View GunComponent methods in the documentation)
______________


<br>

<h1> Documentation </h1> 

<h2> WeaponBehavior Methods: </h2>


_______________

<h4> behavior_shooting_method(_origin: GunComponent, _projectile_position: Vector2, _projectile_rotation: float) </h4>
<p> Code left blank by default, but called during shoot(), fill with how you want a weapon type to work in a script extending BaseWeaponBehavior</p>

_______________

<h4> shoot(origin: GunComponent, projectile_position: Vector2, projectile_rotation: float, _delta: float) </h4>
<p> Call when you want to shoot a weapon (Called by GunComponent shoot_weapon) </p>

______________

<h4> reload(origin: GunComponent) </h4>
<p> Call when you want to reload a weapon (Called by GunComponent reload_weapon) </p>

_______________

<h4> spawn_projectile(origin: GunComponent, projectile_position: Vector2, projectile_rotation: float) </h4>
<p> Spawns a projectile at the specified location and rotation </p>

______________

<br>

<h2> GunComponent Methods: </h2>

______________

<h4> load_weapon(weapon_behavior) </h4>
<p> Loads new WeaponBehavior and replaces the existing one </p>

______________

<h4> shoot_weapon(_delta: float) </h4>
<p> Calls shoot() on the component's WeaponBehavior </p>

______________

<h4> reload_weapon() </h4>
<p> Calls reload() on the component's WeaponBehavior </p>

______________

<br>

<h1> Considerations and Disclaimers </h1>

- The muzzle will automattically place itself at the middle point on the y axis, at the end of the sprite.
- Recoil will be multiplied by _delta, and will only apply is the WeaponHost is a CharacterBody2D
- GunComponent will cause crash if no WeaopnBehavior is attached
- The GunComponent has an "UpPoint" marker node, if this node is above the gun component, the sprite will have it's flip_v set to false. If not, the flip_v will be true.
- The "Projectile Lifespan" setting functions like range, except it's mesured in time not pixels. (This might be replaced with pixel mesurement in the future)
