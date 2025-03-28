extends Area2D
class_name balaPlayer
signal hit
var Bullet = preload("res://bala.tscn") # Replace with function body.
signal shoot(bullet, direction, location)
var velocity = Vector2.RIGHT*700
@export var pool : Pool

var player = preload("res://player.gd")

func _physics_process(delta):
	position += velocity * delta
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	player._pool.return_element(self)
	#queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is Mob: 
		#hide()
		get_tree().get_root().remove_child(self)
		body.has_xocat()
		player._pool.return_element(self)
		body.hide()
		#queue_free() # Replace with function body.
	#	hit.emit()


func _on_hit() -> void:
	hide() # Replace with function body.
