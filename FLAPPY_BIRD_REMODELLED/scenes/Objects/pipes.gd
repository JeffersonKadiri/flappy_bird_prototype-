extends CharacterBody2D

signal update_score

@onready var top_pipe: = get_node("top_pipe")
@onready var bottom_pipe: = get_node("bottom_pipe")

const SPEED = -150.0

func _ready():
	velocity = Vector2(SPEED, 0)

func _on_screen_exited():
	Disable_Shape(top_pipe)
	Disable_Shape(bottom_pipe)
	queue_free()

func _on_area_2d_area_exited(_area):
	update_score.emit()

func _physics_process(delta):
	move_and_collide(velocity * delta)

func Disable_Shape(shape: Node) -> void:
	shape.get_node("CollisionShape2D").set_deferred("disabled", true)

func stop_moving() -> void:
	set_physics_process(false)

func pipe_texture(pipe_node: Node, skin: String) -> void:
	pipe_node.get_node("Sprite2D").texture = load(skin)

func set_pipes_texture(value: String) -> void:
	pipe_texture(top_pipe, value)
	pipe_texture(bottom_pipe, value)
