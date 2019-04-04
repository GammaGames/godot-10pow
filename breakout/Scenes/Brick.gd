extends StaticBody2D
class_name Brick

signal broken

onready var sprite = $Sprite

export var breakable : bool = true

func _ready():
    if breakable:
        add_to_group("brick")
        sprite.texture = load("res://Assets/Sprites/brick.png")
    else:
        sprite.texture = load("res://Assets/Sprites/wall.png")


func break():
    if breakable:
        queue_free()
        emit_signal("broken")
