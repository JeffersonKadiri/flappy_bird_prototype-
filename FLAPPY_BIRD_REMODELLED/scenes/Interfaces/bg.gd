extends ParallaxBackground

@onready var sky: Sprite2D = get_node("Buildings/Background-day")

var scrolling_speed = 100

func _ready():
	sky.texture = load("res://assets/Sprite/FlappyAsset/background-" + str(randi_range(1, 2)) + ".png")

func _process(delta):
	scroll_offset.x -= scrolling_speed * delta 
