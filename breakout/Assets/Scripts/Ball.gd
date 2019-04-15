extends RigidBody2D

onready var paddle = $"../Paddle"
onready var bounce_sound
onready var lose_sound

export var initial_velocity : Vector2 = Vector2(100, -250)
export var velocity : float = 300
export var held : bool = true

func _ready():
    # Duplicate our base nodes
    var sprite = $"../BaseSprite".duplicate()
    bounce_sound = $"../BaseAudioStream".duplicate()
    lose_sound = $"../BaseAudioStream".duplicate()
    # Set our base node resources
    sprite.texture = load("res://Assets/Sprites/ball.png")
    bounce_sound.stream = load("res://Assets/Sounds/bounce.wav")
    lose_sound.stream = load("res://Assets/Sounds/lose.wav")

    # Add our base nodes and connect signals
    add_child(sprite)
    add_child(bounce_sound)
    add_child(lose_sound)
    $VisibilityNotifier2D.connect("screen_exited", self, "_on_screen_exited")
    lose_sound.connect("finished", self, "_on_finished")
    connect("body_entered", self, "_on_body_entered")


func _on_screen_exited():
    lose_sound.play()


func _on_finished():
    get_tree().reload_current_scene()


func _on_body_entered(body):
    if body.has_method("break"):
        body.break()
    else:
        bounce_sound.play()


func _input(event):
    if Input.is_action_just_pressed("ui_accept") and held:
        bounce_sound.play()
        held = false
        set_axis_velocity(initial_velocity)


func _process(delta):
    if held:
        global_position.x = paddle.global_position.x
    elif linear_velocity.length() > initial_velocity.length() * 2:
        apply_impulse(linear_velocity.normalized(), linear_velocity.normalized() * -1 * delta)


func _physics_process(delta):
    set_axis_velocity(linear_velocity.normalized() * (velocity + OS.get_ticks_msec() / 1000))
