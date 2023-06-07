extends TextureButton

signal startGame

@onready var banner: = get_node("Banner")
@onready var score_container: = get_node("ScoreContainer")
@onready var run_container: HBoxContainer = get_node("ScorePanel/RunScoreContainer")
@onready var best_container: HBoxContainer = get_node("ScorePanel/BestScoreContainer")

var score = 0
var best_score = 0

func _on_score_updated():
	score += 1
	score_container.update_score(score)

func _on_pressed():
	disabled = true
	banner.hide()
	startGame.emit()

func score_board() -> void:
	$GameOver.show()
	await get_tree().create_timer(2.0).timeout
	$ScoreContainer.hide()
	$GameOver.hide()
	$ScorePanel.show()
	$RestartButton.show()
	run_container.update_score(score)
	if best_score < score or !score:
		best_container.update_score(score)

func _on_restart_button_pressed():
	get_tree().reload_current_scene()
