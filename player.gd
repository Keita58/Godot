extends Area2D

class_name Player

signal hit

@export var speed = 400
var hp:int=3

var screen_size
var mouse_pos
var area_mouse

# Funció que s'executa quan entrem a l'escena
func _ready():
	screen_size = get_viewport_rect().size
	area_mouse = Area2D.new()
	var col = CollisionShape2D.new()
	var shape = CircleShape2D.new()
	shape.radius = 0.3
	col.shape = shape
	area_mouse.add_child(col)

# Update de Godot
func _process(delta: float):
	mouse_pos = get_viewport().get_mouse_position()
	get_node(".").look_at(mouse_pos)
	area_mouse.position = mouse_pos	
	
	if Input.is_action_pressed("moure_dalt"):
		position += Vector2(1, 0).rotated(rotation) * speed * delta
		$AnimatedSprite2D.play()
	elif Input.is_action_pressed("moure_abaix"):
		position += Vector2(-1, 0).rotated(rotation) * speed * delta
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	
	# Això és per a que no surti de la pantalla
	position = position.clamp(Vector2.ZERO, screen_size)

func _on_body_entered(body: Node2D) -> void:
	if (hp>0): 
		hp-=1
	else:
		hide()
		hit.emit()
		$CollisionShape2D.set_deferred("disabled", true)
	
	if body is Mob:
		(body as Mob).has_xocat()
	
	# Must be deferred as we can't change physics properties on a physics callback.

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
