extends Node2D

onready var timer = $Timer
onready var ball = $"../Ball"
var sound = "bell"
var angle = 0

func _ready():
    timer.connect("timeout", self, "_timeout")


func set_sound(sound):
    self.sound = sound
    match sound:
        "bell":
            $Timer.wait_time = 1.0
            angle = 0
        "kick":
            $Timer.wait_time = 1.0
            angle = 90
        "laser":
            $Timer.wait_time = 1.0
            angle = 180
        "snare":
            $Timer.wait_time = 1.0
            angle = 270
    $Timer.start()


func _timeout():
    var new = ball.duplicate()
    new.call_deferred("set_sound", sound)
    new.vel = Vector2(4, 0).rotated(deg2rad(angle+45))
    $"..".add_child(new)
    new.position = position

    angle += 90
    angle %= 360
