extends HBoxContainer

var index = 0

func update_score(score) -> void:
	var score_to_string = str(score)
	while get_child_count() < score_to_string.length(): add_texture_node()
	for i in get_children():
		i.texture = load("res://assets/Sprite/FlappyAsset/" + score_to_string[index] + ".png")
		index += 1
	index = 0

func add_texture_node():
	var texture_rect: TextureRect = TextureRect.new()
	add_child(texture_rect)
