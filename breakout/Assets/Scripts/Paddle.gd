extends KinematicBody2D

export var speed : int = 500

func _ready():
    add_child(Helper.get_sprite("Assets/Sprites/paddle.png"))


func _physics_process(delta):
    # for calculating our movement velocity
    var mouse_pos : Vector2 = get_viewport().get_mouse_position()
    var mouse_x : int = mouse_pos.x

    # apply and move the body
    var motion : Vector2 = Vector2(mouse_x - global_position.x, 0) * speed * delta
    move_and_slide(motion)


func _input(event):
    if Input.is_action_just_pressed("ui_cancel"):
        get_tree().quit()
    elif Input.is_action_just_pressed("ui_restart"):
        get_tree().reload_current_scene()
