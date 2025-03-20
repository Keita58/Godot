class_name Player
extends Area2D

signal hit

@export var speed = 400
var hp:int=3
var isInvencible:bool=false
var tween:Tween

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
	elif Input.is_action_pressed("moure_esquerra"):
		position += Vector2(-1,0).rotated(rotation) * speed * delta
		$AnimatedSprite2D.play()
	elif Input.is_action_pressed("moure_dreta"):
		position += Vector2(1,0).rotated(rotation) * speed * delta
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
	if (hp>0 and !isInvencible): 
		print("XOCO ENEMIGOd")
		hp-=1
	elif (hp<=0):
		print("XOCO ENEMIGOd")
		hide()
		hit.emit()
		$CollisionShape2D.set_deferred("disabled", true)
	
	if body is Mob:
		(body as Mob).has_xocat()

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _invencible(duration:int)->void:
	isInvencible=true
	var timer:Timer = Timer.new()
	add_child(timer)
	timer.wait_time=duration
	timer.one_shot = true
	var spritePlayer:AnimatedSprite2D = $AnimatedSprite2D
	
	if tween!=null and !tween.is_running():
		tween.kill()
	
	tween = create_tween()
	tween.tween_property(spritePlayer, "modulate", Color.RED, 0.1)
	tween.tween_property(spritePlayer, "modulate", Color.ORANGE, 0.1)
	tween.tween_property(spritePlayer, "modulate", Color.YELLOW, 0.1)
	tween.tween_property(spritePlayer, "modulate", Color.GREEN, 0.1)
	tween.tween_property(spritePlayer, "modulate", Color.BLUE, 0.1)
	tween.tween_property(spritePlayer, "modulate", Color.VIOLET, 0.1)
	tween.tween_property(spritePlayer, "modulate", Color.WHITE, 0.1).set_trans(Tween.TRANS_BOUNCE)
	tween.set_loops()
	timer.start()
	await timer.timeout
	timer.queue_free()
	tween.kill()
	isInvencible=false
	spritePlayer.modulate=Color.WHITE

func _on_area_entered(area: Area2D) -> void:
	if area is PowerUp:
		area.PowerUpType.efectePowerUp(self)
		area.queue_free()
