class_name AmmoPowerUp
extends PowerUpResource

func efectePowerUp(target:Player):
	if target.ammo<10:
		target.ammo+=4
