extends Control

@onready var bg: = get_node("CanvasLayer/Sprite2D")
@onready var pipe_timer: = get_node("CanvasLayer/PipeSpawner/Timer")
@onready var player: = get_node("Player")
@onready var hub: = get_node("HUD/ScoreContainer")

var countdown: = 3

func _ready():
	randomize()
	bg.texture = load("res://assets/Sprite/FlappyAsset/background-" + str(randi_range(1, 2)) + ".png")

func _on_start_game():
	player.ready_anim_play(true)
	player.show_player(true)
	while countdown >= 0:
		hub.update_score(countdown)
		await get_tree().create_timer(1.0).timeout
		countdown -= 1
	player.player_move(true)
	player.ready_anim_play(false)
	pipe_timer.start()

func _on_gameover():
	$Floor.set_process(false)
	pipe_timer.stop()
	player.player_move(false)
	get_tree().call_group("pipes", "stop_moving")
	$HUD.score_board()
