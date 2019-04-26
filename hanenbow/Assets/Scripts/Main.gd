extends Node2D

var start_mouse
var current_mouse
var current_line = null

func _ready():
    var window_size = get_viewport().size
    var x_offset = window_size.x / 5
    var y_offset = window_size.y / 5

    # Create the spawners
    for x in range(4):
        var spawner = $Spawner.duplicate()
        var sound = "bell"
        match x:
            1: sound = "kick"
            2: sound = "laser"
            3: sound = "snare"

        spawner.set_sound(sound)
        add_child(spawner)
        spawner.position = Vector2(x_offset + x_offset * x, y_offset)


func _input(event):
    if event is InputEventMouseButton:
        if event.button_index == BUTTON_LEFT:
            # If we click down, start making a line
            if event.pressed:
                start_mouse = get_viewport().get_mouse_position()
                current_mouse = start_mouse

                if current_line:
                    current_line.queue_free()
                current_line = $Line.duplicate()
                add_child(current_line)
            # Else end the line
            else:
                current_line = null
    elif event is InputEventMouseMotion and current_line:
        current_mouse = get_viewport().get_mouse_position()
        current_line.set_ends(start_mouse, current_mouse)

    elif Input.is_action_just_pressed("ui_cancel"):
        get_tree().quit()
    elif Input.is_action_just_pressed("ui_restart"):
        get_tree().reload_current_scene()
