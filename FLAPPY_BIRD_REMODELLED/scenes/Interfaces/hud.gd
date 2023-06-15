extends TextureButton

signal startGame

@onready var banner: = get_node("Banner")
@onready var game_over_message: = get_node("GameOver")
@onready var score_container: = get_node("ScoreContainer")
@onready var run_container: HBoxContainer = get_node("ScorePanel/RunScoreContainer")
@onready var best_container: HBoxContainer = get_node("ScorePanel/BestScoreContainer")
@onready var death_sound: = get_node("DieSound")

const SAVE_PATH = "res://saveData.bin"

var score: int = 0
var best_score: int = 0

func _ready():
	load_game()

func _on_score_updated():
	score += 1
	score_container.update_score(score)

func _on_pressed():
	disabled = true
	banner.hide()
	startGame.emit()
	score_container.show()

func score_board() -> void:
	game_over_message.show()
	await get_tree().create_timer(2.0).timeout
	death_sound.play()
	score_container.hide()
	game_over_message.hide()
	$ScorePanel.show()
	$ScorePanel/RestartButton.show()
	run_container.update_score(score)
	if best_score < score:
		best_score = score
		saveGame(best_score)
	best_container.update_score(best_score)

func _on_restart_button_pressed():
	get_tree().reload_current_scene()

func load_game() -> void:
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if FileAccess.file_exists(SAVE_PATH) == true:
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			if current_line:
				best_score = current_line["best"]

func saveGame(new_best):
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"best": new_best,
	}
	var jstr = JSON.stringify(data)
	file.store_line(jstr)
