extends Node

@export var mob_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	
	#Guardem al ScriptableObject la puntuació final
	var so_score = load("res://Resource/score_scriptable.tres")
	so_score.score = score
	ResourceSaver.save(so_score)
	#I aquí mirem si la puntuació és la més alta
	var so_best = load("res://Resource/best_score.tres")
	if(so_score.score > so_best.score):
		so_best.score = score
		ResourceSaver.save(so_best)
		
	get_tree().change_scene_to_file("res://game_over_hud.tscn")

func new_game():
	score = 0
	var so_score = load("res://Resource/score_scriptable.tres")
	so_score.score = 0
	ResourceSaver.save(so_score)
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	get_tree().call_group("mobs", "queue_free")

func _on_mob_timer_timeout() -> void:
	var mob:Mob = mob_scene.instantiate()

	var mob_spawn_location = %MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	mob.position = mob_spawn_location.position

	var direction = mob_spawn_location.rotation + PI / 2

	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	mob.onXocarMob.connect(_onSpawnPowerUp, CONNECT_ONE_SHOT)
	add_child(mob)

func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)

func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
	
func _onSpawnPowerUp(powerUp: PowerUp)->void:
	var spawnPossibility:int=randi_range(1, 10)
	if (spawnPossibility<=9):add_child(powerUp)

func _on_mob_shoot(Bullet, direction, location):
	var spawned_bullet = Bullet.instantiate()
	add_child(spawned_bullet)
	spawned_bullet.rotation = direction
	spawned_bullet.position = location
	spawned_bullet.velocity = spawned_bullet.velocity.rotated(direction)
