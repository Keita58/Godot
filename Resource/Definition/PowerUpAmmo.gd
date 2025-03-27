class_name AmmoPowerUp
extends PowerUpResource

func efectePowerUp(target:Player):
	if target.ammo<20:
		target.ammo+=20
