class_name InvenciblePowerUp
extends PowerUpResource

@export var duration:int

func efectePowerUp(target:Player):
	target._invencible(duration)
