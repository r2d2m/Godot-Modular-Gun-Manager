<h1>Godot Modular-Gun-Manager</h1>
<p>A tool for easily adding various types of guns to any 2D Godot game</p>

<br>

<h2>How It Works</h2>
<p>The Modular-Gun-Manager is made up of two components: The <i>WeaponBehavior</i> (An extendable ressource script), and the <i>GunComponent2D</i> (An enxtendable node). The intended usage is for the WeaponBehaviour to serve as list of stats for the aspects of a gun (Recoil, Firerate, etc.), while the GunComponent2D is meant to host a WeaponBehaviour ressource for an entity. Of course there are slight exceptions.</p>

<br>

<h4>WeaponBehaviour's Responsibillities:</h4>
<p>
- Provide a list of the gun's stats and specifications. <br>
- Spawn the gun's projectiles into a scene. <br>
</p>

<h4>GunComponent2D's Responsibillities:</h4>
<p>
- Have a WeaponBehaviour ressource attached to it. <br>
- Manage when a gun can fire or reload. <br>
- Reloading and managing ammo, both in the clip and in reserve. <br>
- Commanding the shooting and reloading of the weapon <br>
</p>

<br>
<p>Because of these responsibillities, it is possible for a WeaponBehaviour to function without being attached to a GunComponen2D, however, certains aspects of the gun will not function (Ammo, Firerate, Burst Fire, etc.) The GunComponent2D is also meant to be child of to a CharaterBody2D (To allow for recoil), but does have to be.</p>

<br>
<p>When implementing into a game, it is intended to extend both the WeaponBehavior and GunComponent2D to fit the needs of the type of game (For example, providing a setting for the weapon's sprite in a top-down shooter). <i>There are already pre-built weapons types included, but they may not be perfect.</i></p>

<br>

<h2>How To Implement And Use</h2>
<p>
  1. Drag the Modular-Gun-Manager Folder into your project. <br>
  2. Extend WeaponBehaviour and GunComponent2D to fit your type of project (Or use the included pre-built versions). <br>
  3. Add the appropriate extended GunComponent2D to an entity. <br>
  4. With the appropriate extended WeaponBehaviour, create a new weapon ressource. <br>
  5. Modify this ressource's settings to fit the needs of your new weapon. <br>
  6. Attach the ressource to the used GunComponent2D. <br>
  7. Connect the GunComponent2D's commands through code. <br>
</p>
<br>

<h3>Important Considerations</h3>
<p>Damage is assigned to a weapon via an <i>AttackInstance</i> ressource, this is a standard in my games. Although I would recommend adapting to this standard, it can be removed without issue.</p>
<br>
<p>Projectiles are recomended to inherit from the <i>Projectile</i> class defined in <i>projectile.gd</i>, this allows the WeaponBehaviour of the gun it was shot from to be attached to it. Allowing for range, damage, and other factors to be calculated</p>

<br>
<h2>Documentation</h2>
<br>
<h3>GunComponent2D Functions:</h3>
<h4>shoot_weapon():</h4>
<p>Called externally when wanting to make the attached weapon fire.</p>
<h4>reload_weapon():</h4>
<p>Called externally when wanting to reload the attached weapon.</p>
<h4>load_weapon(new_weapon: WeaponBehavior):</h4>
<p>Called externally when wanting to replace the attached weapon through code.</p>
<h4>get_reload_info(ammo_in_clip: int, max_ammo_in_clip: int, ammo_stocked: int):</h4>
<p>Takes the inputed numbers and determines how much ammo is reloaded. Called by reload_weapon().</p>
<br>
<h4>custom_shoot_weapon():</h4>
<p>Empty function, meant to include code when extending GunComponend2D. Called by shoot_weapon()</p>
<h4>custom_shoot_failed():</h4>
<p>Empty function, meant to include code when extending GunComponend2D. Called when the weapon is attempted to be shot, but lacks ammo.</p>
<h4>custom_reload_begin():<h4>
<p>Empty function, meant to include code when extending GunComponend2D. Called at the beginning of a reload.</p>
<h4>custom_reload_end():</h4>
<p>Empty function, meant to include code when extending GunComponend2D. Called on reload completion.</p>
<h4>custom_reload_failed():</h4>
<p>Empty function, meant to include code when extending GunComponend2D. Called when a reload is attempted, but lacks ammo.</p>
<h4>custom_load_weapon():</h4>
<p>Empty function, meant to include code when extending GunComponend2D. Called by load_weapon, after the previous weapon had been replaced by the new weapon.</p>
<h4>custom_destroy_weapon():</h4>
<p>Empty function, meant to include code when extending GunComponend2D. Called by load_weapon, before the previous weapon had been replaced by the new weapon.</p>
<h4>custom_ready():</h4>  
<p>Empty function, meant to include code when extending GunComponend2D. Called by _ready()</p>
<h4>custom_process(_delta: float):</h4>
<p>Empty function, meant to include code when extending GunComponend2D. Called by _process()</p>
<br>
<br>

<h3>WeaponBehaviour Functions:</h3>
<h4>shoot(_origin: Node2D, _projectile_position: Vector2, _projectile_rotation: float):</h4>
<p>Shoots the weapon at the assigned position and rotation, in the same scene as _origin.</p>
<h4>spawn_projectile(origin: Node2D, projectile_position: Vector2, projectile_rotation: float):</h4>
<p>Spawns the weapon behaviour's assigned projectile.</p>
