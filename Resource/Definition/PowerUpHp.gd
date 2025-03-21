class_name HPPowerUp
extends PowerUpResource

func efectePowerUp(target:Player):
	target.hp += 1
	print("ME CUROOO")
	target.hurt.emit(target.hp)
