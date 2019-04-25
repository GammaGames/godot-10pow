extends StaticBody2D

onready var shape = $CollisionShape2D
var sprite
var start
var end


func _ready():
    $CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()
    sprite = $"../BaseSprite".duplicate()
    sprite.texture = load("res://Assets/Sprites/line.png")
    add_child(sprite)
    connect("input_event", self, "_input_event")


func set_ends(start, end):
    add_to_group("line")
    visible = true
    self.start = start
    self.end = end
    if shape:
        shape.shape.height = start.distance_to(end)
        shape.position = (start + end) / 2
        shape.rotation = start.angle_to_point(end) + PI / 2

    if sprite:
        sprite.position = shape.position
        sprite.rotation = shape.rotation + PI / 2
        sprite.scale = Vector2(start.distance_to(end), 1)


func _input_event(viewport, event, shape_idx):
	# delete line when right clicked
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_RIGHT:
            queue_free()
