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

