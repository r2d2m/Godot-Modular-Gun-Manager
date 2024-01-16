extends WeaponBehavior
class_name TopDownWeaponBehavior

@export_category("[Top Down Behaviour] Sprite Settings")
@export var weapon_sprite: SpriteFrames
@export var animate_sprite_actions: bool = true
@export var auto_flip_sprite: bool = true

@export_category("[Top Down Behaviour] Sparks")
@export var sparks_enabled: bool = true
@export var sparks_texture: Texture
@export var sparks_modulate: Color = Color(0.988, 0.749, 0.333)
