extends RigidBody2D

onready var paddle = $"../Paddle"

export var initial_velocity : Vector2 = Vector2(200, -200)
export var held : bool = true


func _ready():
    linear_velocity = initial_velocity
    add_to_group("ball")
    connect("body_entered", self, "_on_body_entered")


func _on_body_entered(body):
    if body.has_method("break"):
        body.break()


func _input(event):
    if Input.is_action_just_pressed("ui_accept"):
        held = false
        linear_velocity = initial_velocity

func _process(delta):
    if held:
        global_position.x = paddle.global_position.x
    elif linear_velocity.length() > initial_velocity.length() * 2:
        apply_impulse(linear_velocity.normalized(), linear_velocity.normalized() * -1 * delta)
