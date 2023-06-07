extends Node2D

signal score_updated

var Pipes: = preload("res://scenes/Objects/pipes.tscn") 

@onready var timer: Timer = get_node("Timer")

func _on_timer_timeout():
	var pipe = Pipes.instantiate()
	pipe.position.y = randi_range(-112, 80)
	pipe.update_score.connect(add_score)
	add_child(pipe)

func add_score():
	score_updated.emit()
