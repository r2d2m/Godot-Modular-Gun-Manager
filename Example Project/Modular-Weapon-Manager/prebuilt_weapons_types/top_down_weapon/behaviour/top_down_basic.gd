extends TopDownWeaponBehavior
class_name TopDownBasicWeapon

func custom_shoot(_origin: Node2D, _projectile_position: Vector2, _projectile_rotation: float):
	spawn_projectile(_origin, _projectile_position, _projectile_rotation)
