extends KinematicBody2D

export var speed : int = 500


func _physics_process(delta):
    # for calculating our movement velocity
    var mouse_pos : Vector2 = get_viewport().get_mouse_position()
    var mouse_x : int = mouse_pos.x

    # apply and move the body
    var motion : Vector2 = Vector2(mouse_x - global_position.x, 0) * speed * delta
    move_and_slide(motion)
