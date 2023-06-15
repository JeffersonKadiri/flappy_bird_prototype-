extends Node2D

signal score_updated

@onready var point: AudioStreamPlayer2D = get_node("PointSound")

const pipe_textures = ["res://assets/Sprite/FlappyAsset/pipe-green.png", "res://assets/Sprite/FlappyAsset/pipe-red.png"]

var Pipes: = preload("res://scenes/Objects/pipes.tscn") 
var texture: String

func _ready():
	texture = pipe_textures[(randi() % pipe_textures.size())]

func _on_timer_timeout():
	var pipe = Pipes.instantiate()
	pipe.position.y = randi_range(-112, 80)
	pipe.update_score.connect(add_score)
	add_child(pipe)
	pipe.set_pipes_texture(texture)

func add_score():
	point.play()
	score_updated.emit()
