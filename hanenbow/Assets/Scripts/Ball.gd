extends Node2D

var processing = false
var vel = Vector2()
var prevpos = Vector2()
var sprite
var sound
var audio_stream
var notes = []

func _ready():
    sprite = $"../BaseSprite".duplicate()
    audio_stream = $"../BaseAudioStream".duplicate()
    sprite.texture = load("res://Assets/Sprites/ball.png")
    add_child(sprite)
    add_child(audio_stream)
    $VisibilityNotifier2D.connect("screen_exited", self, "queue_free")


func set_sound(sound):
    visible = true
    self.sound = sound
    self.notes = self.gen_notes()
    prevpos = position
    var goalcol = Color(0,0,0)
    match sound:
        "bell": goalcol = Color(0,1,1)
        "kick": goalcol = Color(1,0,0)
        "snare": goalcol = Color(0,1,0)
        "laser": goalcol = Color(1,1,0)

    audio_stream.stream = load("res://Assets/Sounds/{0}.wav".format([sound]))
    sprite.modulate = goalcol
    processing = true


func gen_notes():
    var notes = []
    seed(3)
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


func _physics_process(delta):
    if processing:
        vel += Vector2(0, 20 * 1) * delta
        prevpos = position
        position += vel

        # manual collision
        var colliders = get_tree().get_nodes_in_group("line")
        for c in colliders:
            var p1 = c.start
            var p2 = c.end
            if p1 and p2:
                var norm = (p2-p1).tangent().normalized()
                var coll = Geometry.segment_intersects_segment_2d(prevpos, position, p1, p2)
                if coll != null:
                    if vel.length() > 1.0:
                        var pitch = vel.length()
                        if sound != "bell":
                            pitch *= 2

                        pitch = notes[round(pitch)]
                        pitch += rand_range(-1,1)*0.002
                        var stream = audio_stream.duplicate()
                        stream.stream = stream.stream.duplicate()
                        $"..".add_child(stream)
                        stream.stream.mix_rate = pitch * 44100.0
                        stream.play()
                        stream.connect("finished", stream, "queue_free")

                    if vel.dot(norm) > 0:
                        norm = -norm

                    var restitution = 0.8
                    vel = (-vel.reflect(norm)).linear_interpolate(vel.slide(norm), 1-restitution)
                    position = coll + norm * 0.1
