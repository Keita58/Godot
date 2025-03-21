class_name Player
extends Area2D

signal hit
signal iniciarTimerPowerUp(duration:int)

@export var speed = 400
var hp:int=3
var isInvencible:bool=false
var tween:Tween

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
	if hp>0 and !isInvencible: 
		print("XOCO ENEMIGO")
		hp-=1
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
		if (hp>0 and !isInvencible): 
			print("XOCO ENEMIGOd")
			hp-=1
		elif (hp<=0):
			print("XOCO ENEMIGOd")
			hide()
			hit.emit()
			$CollisionShape2D.set_deferred("disabled", true)
