extends VisibilityNotifier2D

func _ready():
    randomize()
    var paddle = load("res://Scenes/Paddle.tscn").instance()
    paddle.global_position = Vector2(160, 496)
    add_child(paddle)
    var ball = load("res://Scenes/Ball.tscn").instance()
    ball.global_position = Vector2(160, 470)
    add_child(ball)

    var map = []
    for y in range(13): # Fill map
        var row = []
        row.resize(9)
        for x in range(row.size()):
            row[x] = '#' if randf() > 0.6 else ' '
        map.append(row)

    var valid = false
    while !valid: # Iterate and validate map
        for i in 4:
            iterate(map, true)
        for i in 3:
            iterate(map)
        var m = flood_map(map)
        valid = check_map(m, '.', 0.2, 0.6)

    for y in range(-1, map.size() + 3): # Create map walls
        instance_brick(-1, y, false)
        instance_brick(map[0].size(), y, false)
    for x in range(map[0].size()):
        instance_brick(x, -1, false)

    for y in range(map.size()):
        for x in range(map[y].size()):
            if map[y][x] != ' ':
                instance_brick(x, y, map[y][x] == '#')

func instance_brick(x, y, breakable=false):
    var brick_instance = load("res://Scenes/Brick.tscn").instance()
    brick_instance.breakable = breakable
    add_child(brick_instance)
    brick_instance.global_position = Vector2(x * 32 + 32, y * 32 + 32)


func iterate(map, empty=false):
    var m = clone_map(map)
    for y in range(map.size()):
        for x in range(map[y].size()):
            map[y][x] = ' ' if check_surrounding(x, y, '#', m, empty) else '#'

func check_surrounding(x, y, ch, map, empty=false):
    var count = 0
    for yy in range(-1, 2):
        for xx in range(-1, 2):
            var X = x + xx
            var Y = y + yy
            count += 1 if 0 < X and X < map[0].size() and 0 < Y and Y < map.size() and map[Y][X] == ch else 0
    return (not empty and count >= 5) or (empty and (count >= 5 or count == 0))

func clone_map(map):
    var m = []
    for row in map:
        m.append([] + row)
    return m

func flood_map(map):
    var m = clone_map(map)
    var valid = false
    var x
    var y
    while !valid:
        x = randi() % map[0].size()
        y = randi() % map.size()
        valid = m[y][x] == ' '
    m[y][x] = '.'
    flood(m, x, y)
    return m

func flood(map, x, y):
    map[y][x] = '.'
    if x - 1 >= 0 and map[y][x - 1] == ' ':
        flood(map, x - 1, y)
    if x + 1 < map[0].size() and map[y][x + 1] == ' ':
        flood(map, x + 1, y)
    if y - 1 >= 0 and map[y - 1][x] == ' ':
        flood(map, x, y - 1)
    if y + 1 < map.size() and map[y + 1][x] == ' ':
        flood(map, x, y + 1)

func check_map(map, ch, mi, ma):
    var count = 0
    for row in map:
        for c in row:
            count += 1 if c == ch else 0
    var percent = float(count) / (map.size() * map[0].size())
    return percent >= mi and percent <= ma
