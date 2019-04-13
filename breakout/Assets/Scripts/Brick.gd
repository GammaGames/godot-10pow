extends StaticBody2D
class_name Brick

signal broken

export var breakable : bool = true

func _ready():
    # TODO randomize brick texture
    var sprite_path = ""
    if breakable:
        add_to_group("brick")
        sprite_path = "Assets/Sprites/brick.png"
    else:
        sprite_path = "Assets/Sprites/wall.png"
    add_child(Helper.get_sprite(sprite_path))


func break():
    if breakable:
        remove_from_group("brick")
        if not get_tree().get_nodes_in_group("brick").size():
            get_tree().reload_current_scene()
        queue_free()
