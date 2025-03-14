extends Area2D
signal hit

@export var speed = 400
var screen_size

# Funció que s'executa quan entrem a l'escena
func _ready():
	screen_size = get_viewport_rect().size
	hide()

# Update de Godot
func _process(delta: float):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("moure_dalt"):
		velocity.y -= 1
	if Input.is_action_pressed("moure_abaix"):
		velocity.y += 1
	if Input.is_action_pressed("moure_esquerra"):
		velocity.x -= 1
	if Input.is_action_pressed("moure_dreta"):
		velocity.x += 1
	
	if Input.is_action_pressed("camera_dreta"):
		velocity.x += 1
	elif Input.is_action_pressed("camera_esquerra"):
		velocity.x += 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0


func _on_body_entered(body: Node2D) -> void:
	hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
