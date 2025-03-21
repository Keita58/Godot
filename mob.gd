extends RigidBody2D

signal shoot(bullet, direction, location)

var Bullet = preload("res://bala.tscn") # Replace with function body.

func _ready() -> void:
	$ShootTimer.start()
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = mob_types.pick_random()
	$AnimatedSprite2D.play()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

	
func _shoot()->void:
	var bullet_instance = Bullet.instantiate()
	get_tree().get_root().add_child(bullet_instance)

func _on_shoot_timer_timeout() -> void:
		var bullet_instance = Bullet.instantiate()
		bullet_instance.position = position
		bullet_instance.rotation = rotation 
		get_tree().get_root().add_child(bullet_instance)
		
