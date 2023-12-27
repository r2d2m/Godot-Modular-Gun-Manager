extends WeaponBehavior
class_name BasicWeapon

func behavior_shooting_method(_origin: GunComponent, _projectile_position: Vector2, _projectile_rotation: float):
	spawn_projectile(_origin, _projectile_position, _projectile_rotation)
