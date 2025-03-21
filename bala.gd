class_name Bala
extends Area2D
signal shoot(bullet, direction, location)

var velocity = Vector2.RIGHT*700

func _physics_process(delta):
	position += velocity * delta
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
