class_name PowerUp
extends Area2D

var nom:String
var PowerUpType:PowerUpResource

func load_from(info:PowerUpResource)->void:
	PowerUpType=info
	$Sprite2D.texture=info.sprite
	nom=info.name
	scale=info.scale
