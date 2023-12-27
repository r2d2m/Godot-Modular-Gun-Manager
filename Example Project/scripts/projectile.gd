extends CharacterBody2D
class_name Projectile

@export var weapon_behavior: WeaponBehavior
@export var player_owned: bool

@onready var base_sprite: AnimatedSprite2D = $BulletBase
@onready var timer: Timer = $LifespanTimer

var direction: Vector2

func _ready() -> void:
	base_sprite.sprite_frames = weapon_behavior.projectile_sprite
	timer.start(weapon_behavior.projectile_lifespan)

func _physics_process(delta: float) -> void: 
	velocity = direction * delta
	
	direction = Vector2(weapon_behavior.projectile_speed, 0).rotated(rotation)
	base_sprite.sprite_frames = weapon_behavior.projectile_sprite
	scale = Vector2(weapon_behavior.projectile_scale, weapon_behavior.projectile_scale)
	
	if base_sprite.sprite_frames:
		base_sprite.play("default")
	
	move_and_slide()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_lifespan_timer_timeout() -> void:
	queue_free()
	pass
