extends Projectile
class_name BasicBullet

@export var player_owned: bool

@onready var base_sprite: AnimatedSprite2D = $BulletBase

var direction: Vector2
var starting_position: Vector2

func _ready() -> void:
	starting_position = global_position
	scale = Vector2(weapon_behavior.projectile_scale, weapon_behavior.projectile_scale)

func _physics_process(delta: float) -> void: 
	
	if global_position.distance_to(starting_position) > weapon_behavior.projectile_range:
		queue_free()
	
	if base_sprite.sprite_frames.animations.has("default"):
		base_sprite.play("default")
	
	
	direction = Vector2(weapon_behavior.projectile_speed, 0).rotated(rotation)
	
	velocity = direction * delta
	
	move_and_slide()
