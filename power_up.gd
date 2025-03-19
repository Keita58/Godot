class_name PowerUp
extends Area2D

var nom:String

func load_from(info:PowerUpResource)->void:
	$Sprite2D.texture=info.sprite
	nom=info.name
	
