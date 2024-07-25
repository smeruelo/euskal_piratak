extends Camera2D

@export var _subject : Node2D
@export var _offset : Vector2


func _ready():
	position.x = _subject.position.x + offset.x

func _process(_delta):
	position.x = _subject.position.x + offset.x
