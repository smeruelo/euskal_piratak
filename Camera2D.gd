extends Camera2D

@export var _subject : Node2D

func _process(_delta):
	position.x = _subject.position.x	
