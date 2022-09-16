extends Node2D

@export var Bullet: PackedScene

@onready var sprite = $Sprite
@onready var baseOffset = sprite.offset

func _process(delta):
	var need_to_flip = abs(global_rotation) > PI/2 and abs(global_rotation) < 3*PI/2
#	sprite.flip_v = need_to_flip
	scale.y = -1 if need_to_flip else 1
	sprite.offset = baseOffset * (-1 if need_to_flip else 1)
