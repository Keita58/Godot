class_name Bala
extends Area2D
var Bullet = preload("res://bala.tscn") # Replace with function body.

signal shoot(bullet, direction, location)

var velocity = Vector2.RIGHT*700


func _physics_process(delta):
	position += velocity * delta
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_bala_explosiva_timer_timeout() -> void:
	hide()
	var bullet_instance = Bullet.instantiate()
	var spriteBullet:Sprite2D=bullet_instance.get_child(0)
	spriteBullet.modulate = Color.RED
	bullet_instance.position = position
	bullet_instance.rotation = 360
	bullet_instance.velocity = bullet_instance.velocity.rotated(rotation)
	get_tree().get_root().add_child(bullet_instance)
	var bullet_instance2 = Bullet.instantiate()
	var spriteBullet2:Sprite2D=bullet_instance2.get_child(0)
	spriteBullet2.modulate = Color.RED
	bullet_instance2.position = position
	bullet_instance2.rotation = 90
	bullet_instance2.velocity = bullet_instance2.velocity.rotated(bullet_instance2.rotation)
	get_tree().get_root().add_child(bullet_instance2)
	var bullet_instance3 = Bullet.instantiate()
	var spriteBullet3:Sprite2D = bullet_instance3.get_child(0)
	spriteBullet3.modulate = Color.RED
	bullet_instance3.position = position
	bullet_instance3.rotation = 270
	bullet_instance3.velocity = bullet_instance3.velocity.rotated(bullet_instance3.rotation)
	get_tree().get_root().add_child(bullet_instance3)
	var bullet_instance4 = Bullet.instantiate()
	bullet_instance4.position = position
	bullet_instance4.rotation = 180
	bullet_instance4.velocity = bullet_instance4.velocity.rotated(bullet_instance4.rotation)
	get_tree().get_root().add_child(bullet_instance4)
