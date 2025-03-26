class_name Player
extends Area2D

signal hit
signal iniciarTimerPowerUp(duration:int)
signal hurt(vida:int)

@export var speed = 300
var hp:int = 3
var ammo:int=20
var isInvencible:bool=false
var tween:Tween

var screen_size
var mouse_pos

# Funció que s'executa quan entrem a l'escena
func _ready():
	screen_size = get_viewport_rect().size

# Update de Godot
func _process(delta: float):
	"""
	if Input.is_action_pressed("moure_dalt"):
		position += Vector2(0, -1).rotated(rotation) * speed * delta
		$AnimatedSprite2D.play()
	elif Input.is_action_pressed("moure_abaix"):
		position += Vector2(0, 1).rotated(rotation) * speed * delta
		$AnimatedSprite2D.play()
	elif Input.is_action_pressed("moure_esquerra"):
		position += Vector2(-1, 0).rotated(rotation) * speed * delta
		$AnimatedSprite2D.play()
	elif Input.is_action_pressed("moure_dreta"):
		position += Vector2(1, 0).rotated(rotation) * speed * delta
	else:
		$AnimatedSprite2D.stop()
	
	if Input.is_action_pressed("camera_dreta"):
		rotation_degrees += 3
	elif Input.is_action_pressed("camera_esquerra"):
		rotation_degrees -= 3
	"""
	if hp<=0:
		hide()
		hit.emit()
	else:
		mouse_pos = get_viewport().get_mouse_position()
		get_node(".").look_at(mouse_pos)
		if(position.distance_to(get_viewport().get_mouse_position()) > 5):
			#print_debug(position.distance_to(get_viewport().get_mouse_position()))
			#position = position.lerp(Vector2(1, 0).rotated(rotation), speed * delta)
			position += Vector2(1, 0).rotated(rotation) * speed * delta
			$AnimatedSprite2D.play()
		else:
			$AnimatedSprite2D.stop()
	
	# Això és per a que no surti de la pantalla
	position = position.clamp(Vector2.ZERO, screen_size)

func _on_body_entered(body: Node2D) -> void:
	if hp > 0 and !isInvencible: 
		print("XOCO ENEMIGO")
		hp -= 1
		hurt.emit(hp)
	elif hp<=0:
		print("XOCO ENEMIGO muelto")
		hide()
		hit.emit()
		$CollisionShape2D.set_deferred("disabled", true)
	
	if isInvencible:
		print("SOY INVENCIBLE")
	
	if body is Mob:
		(body as Mob).has_xocat()

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _invencible(duration:int)->void:
	iniciarTimerPowerUp.emit(duration)
	if tween!=null and tween.is_running():
		tween.kill()

	isInvencible=true
	#Timer per a la duració del powerUp
	var timer:Timer = Timer.new()
	add_child(timer)
	timer.start(duration)
	timer.one_shot = true
	var spritePlayer:AnimatedSprite2D = $AnimatedSprite2D

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

#func crearTimerPowerUp(duration:int)->void:
	#var tempsMaxim:int=duration
	#while duration>=0:
		#var timeLeftPowerUp:Timer = Timer.new()
		#timeLeftPowerUp.wait_time=1
		#await timeLeftPowerUp.timeout
		#duration-=1

func _on_area_entered(area: Area2D) -> void:
	if area is PowerUp:
		area.PowerUpType.efectePowerUp(self)
		area.queue_free()
	if area is Bala:
		area.hide()
		area.queue_free()
		if hp>0 and !isInvencible: 
			print("XOCO ENEMIGOd")
			hp-=1
			print("HP: "+str(hp))
			hurt.emit(hp)
		elif hp<=0:
			print("XOCO ENEMIGOd")
			hide()
			hit.emit()
			$CollisionShape2D.set_deferred("disabled", true)
