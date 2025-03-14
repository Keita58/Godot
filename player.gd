extends Area2D
signal hit

@export var speed = 400
var screen_size

# Funció que s'executa quan entrem a l'escena
func _ready():
	screen_size = get_viewport_rect().size
	#hide()

# Update de Godot
func _process(delta: float):
	if Input.is_action_pressed("moure_dalt"):
		position += Vector2(0,-1).rotated(rotation) * speed * delta
		$AnimatedSprite2D.play()
	elif Input.is_action_pressed("moure_abaix"):
		position += Vector2(0,1).rotated(rotation) * speed * delta
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	if Input.is_action_pressed("camera_dreta"):
		rotation_degrees += 3
	elif Input.is_action_pressed("camera_esquerra"):
		rotation_degrees -= 3
	
	# Això és per a que no surti de la pantalla
	position = position.clamp(Vector2.ZERO, screen_size)

func _on_body_entered(body: Node2D) -> void:
	hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
