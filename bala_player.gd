extends Area2D
class_name balaPlayer
signal hit
var Bullet = preload("res://bala.tscn") # Replace with function body.

signal shoot(bullet, direction, location)

var velocity = Vector2.RIGHT*700


func _physics_process(delta):
	position += velocity * delta
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is Mob: 
		hide()
		body.has_xocat()
		#body.hide()
		queue_free() # Replace with function body.
		hit.emit()


func _on_hit() -> void:
	hide() # Replace with function body.
