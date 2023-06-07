extends CharacterBody2D

signal update_score

@onready var top_pipe: = get_node("top_pipe/CollisionShape2D")
@onready var bottom_pipe: = get_node("bottom_pipe/CollisionShape2D")

const SPEED = -100.0

func _ready():
	velocity = Vector2(SPEED, 0)

func _on_screen_exited():
	Disable_Shape(top_pipe)
	Disable_Shape(bottom_pipe)
	queue_free()

func _on_area_2d_area_exited(area):
	update_score.emit()

func _physics_process(delta):
	move_and_collide(velocity * delta)

func Disable_Shape(shape: Node) -> void:
	shape.set_deferred("disabled", true)

func stop_moving() -> void:
	set_physics_process(false)
