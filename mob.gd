class_name Mob
extends RigidBody2D

signal onXocarMob (powerUp:PowerUp)

@export var power_upScene:PackedScene
@export var powerUpConfigurations:Array[PowerUpResource]

func _ready() -> void:
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = mob_types.pick_random()
	$AnimatedSprite2D.play()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	#Recorrer getConnections y desconectar.

func has_xocat() -> void:
	print_debug("xoco")
	var power_up=power_upScene.instantiate() as PowerUp
	print_debug("instancio powerUp")
	power_up.load_from(powerUpConfigurations[randi_range(0, powerUpConfigurations.size()-1)])
	power_up.position=global_position
	print_debug(power_up.global_position)
	onXocarMob.emit(power_up)
	queue_free()


func _onSpawnPowerUp(powerUp: PowerUp) -> void:
	pass # Replace with function body.
