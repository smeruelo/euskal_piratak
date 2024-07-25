extends Node2D

@export var scroll_speed : float = -90
@export var width : float = 899
@onready var _big_cloud_1 : Sprite2D = $BigCloud1
@onready var _big_cloud_2 : Sprite2D = $BigCloud2
@onready var _small_cloud_1 : Sprite2D = $SmallCloud1
@onready var _small_cloud_2 : Sprite2D = $SmallCloud2


func _process(delta):
	_move_cloud(_big_cloud_1, scroll_speed * delta)
	_move_cloud(_big_cloud_2, scroll_speed * delta)
	_move_cloud(_small_cloud_1, scroll_speed * delta / 5)
	_move_cloud(_small_cloud_2, scroll_speed * delta / 3)
	

func _move_cloud(cloud, distance):
	cloud.position.x += distance
	if cloud.position.x < width * -0.5 :
		cloud.position.x += width * 2
		
	
