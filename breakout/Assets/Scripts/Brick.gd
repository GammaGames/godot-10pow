extends StaticBody2D
class_name Brick

var hit_sound

onready var shape = $CollisionShape2D

export var breakable : bool = true

func _ready():
    # Duplicate our base nodes
    var sprite = $"../BaseSprite".duplicate()
    hit_sound = $"../BaseAudioStream".duplicate()
    # Set our base node resources
    if breakable:
        add_to_group("brick")
        sprite.texture = load("res://Assets/Sprites/brick.png")
        hit_sound.stream = load("res://Assets/Sounds/boom.wav")
        hit_sound.connect("finished", self, "_on_finished")
    else:
        sprite.texture = load("res://Assets/Sprites/wall.png")
        hit_sound.stream = load("res://Assets/Sounds/bounce.wav")
    # Add our base nodes
    add_child(sprite)
    add_child(hit_sound)


func _on_finished():
    if not get_tree().get_nodes_in_group("brick").size():
        get_tree().reload_current_scene()
    queue_free()


func break():
    hit_sound.play()
    if breakable:
        remove_from_group("brick")
        visible = false
        shape.call_deferred("set_disabled", true)
