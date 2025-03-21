extends CanvasLayer

func _ready() -> void:
	show_score()

func show_score() -> void:
	var so_score = load("res://Resource/score_scriptable.tres")
	$TotalScore.text += str(so_score.score)
	
	var so_best = load("res://Resource/best_score.tres")
	$BestScore.text += str(so_best.score)

func _on_return_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
