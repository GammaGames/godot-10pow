extends StaticBody2D
class_name Brick

signal broken

onready var sprite = $Sprite

export var breakable : bool = true

func _ready():
    # TODO randomize brick texture
    if breakable:
        add_to_group("brick")
        sprite.texture = load("res://Assets/Sprites/brick.png")
    else:
        sprite.texture = load("res://Assets/Sprites/wall.png")


func break():
    if breakable:
        remove_from_group("brick")
        if not get_tree().get_nodes_in_group("brick").size():
            get_tree().reload_current_scene()
        queue_free()
