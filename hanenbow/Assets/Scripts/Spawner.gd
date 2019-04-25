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
    new.notes = gen_notes()
    new.vel = Vector2(4, 0).rotated(deg2rad(angle+45))
    $"..".add_child(new)
    new.position = position

    angle += 90
    angle %= 360


func gen_notes():
    var notes = []
    #seed(hash(angle+1))
    seed(3) # seed = 2 is nice
    randi()

    var base_pitch = 0.06
    var note1 = pow(2, 1 + randi() % 12/12.0)
    var note2 = pow(2, 1 + randi() % 12/12.0)
    var note3 = pow(2, 1 + randi() % 12/12.0)

    notes.push_back(2 * base_pitch)
    notes.push_back(note1 * base_pitch)
    notes.push_back(note2 * base_pitch)
    notes.push_back(note3 * base_pitch)

    for i in 100:
        var n1 = notes[-1]
        var n2 = notes[-2]
        var n3 = notes[-3]
        var n4 = notes[-4]

        notes.push_back(n1 * 2)
        notes.push_back(n2 * 2)
        notes.push_back(n3 * 2)
        notes.push_back(n4 * 2)

    randomize()
    return notes
