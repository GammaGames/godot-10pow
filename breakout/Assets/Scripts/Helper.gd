extends Node

var main

func _ready():
    get_main()

func get_main():
    # Get a weak reference so we can check if it was freed
    main = weakref(get_tree().get_root().get_node("Main"))

func get_sprite(sprite_path):
    # Duplicate the base sprite and return it
    if !main.get_ref():
        # Get a main if we need to
        get_main()
    var sprite = main.get_ref().get_node("BaseSprite").duplicate()
    sprite.texture = load("res://{path}".format({"path": sprite_path}))
    return sprite

func get_audio_stream(audio_path):
    # Duplicate the base audio stream and return it
    if !main.get_ref():
        # Get a main if we need to
        get_main()
    var stream = main.get_ref().get_node("BaseAudioStream").duplicate()
    stream.texture = load("res://{path}".format({"path": audio_path}))
    return stream
