extends StaticBody2D
class_name Brick

var boom_sound
var bounce_sound

onready var shape = $CollisionShape2D

export var breakable : bool = true

func _ready():
    # TODO randomize brick texture
    var sprite_path = ""
    if breakable:
        add_to_group("brick")
        sprite_path = "Assets/Sprites/brick.png"
        boom_sound = Helper.get_audio_stream("Assets/Sounds/boom2.wav")
        add_child(boom_sound)
        boom_sound.connect("finished", self, "_on_finished")
    else:
        sprite_path = "Assets/Sprites/wall.png"
        bounce_sound = Helper.get_audio_stream("Assets/Sounds/bounce.wav")
        add_child(bounce_sound)
    add_child(Helper.get_sprite(sprite_path))


func _on_finished():
    if not get_tree().get_nodes_in_group("brick").size():
        get_tree().reload_current_scene()
    queue_free()


func break():
    if breakable:
        visible = false
        shape.disabled = true
        boom_sound.play()
        remove_from_group("brick")
    else:
        bounce_sound.play()
