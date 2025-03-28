class_name Mob
extends RigidBody2D

var Bullet = preload("res://bala.tscn") # Replace with function body.
var Bullet2 = preload("res://balaExplosiva.tscn") # Replace with function body.

signal onXocarMob (powerUp:PowerUp)
signal shoot(bullet, direction, location)

@export var power_upScene:PackedScene
@export var powerUpConfigurations:Array[PowerUpResource]

func _ready() -> void:
	$ShootTime.start()
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = mob_types.pick_random()
	$AnimatedSprite2D.play()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	#Recorrer getConnections y desconectar.

func has_xocat() -> void:
	if (randf_range(1,10)<=5):
		var power_up=power_upScene.instantiate() as PowerUp
		power_up.load_from(powerUpConfigurations[randi_range(0, powerUpConfigurations.size()-1)])
		power_up.position=global_position
		onXocarMob.emit(power_up)
		queue_free()
	else:
		queue_free()

func _shoot()->void:
	var bullet_instance = Bullet.instantiate()
	get_tree().get_root().add_child(bullet_instance)

func _on_shoot_time_timeout() -> void:
	var bullet_instance = null
	if (randi() % 2) == 0:
		bullet_instance = Bullet.instantiate()
	else:
		bullet_instance = Bullet2.instantiate()
		var spriteBullet:Sprite2D=bullet_instance.get_child(0)
		spriteBullet.modulate = Color.RED
		bullet_instance.velocity = Vector2.RIGHT*300
	bullet_instance.position = position
	bullet_instance.rotation = rotation
	bullet_instance.velocity = bullet_instance.velocity.rotated(rotation)
	get_tree().get_root().add_child(bullet_instance)
