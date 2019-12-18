extends Node

class_name ComponenteEntradaJugador

signal detector_entrada(direccion)

func _ready():
	pass

func _input(event):
	if event.is_action_pressed("ui_up"):
		var direccion: Vector2 = Vector2(0, -1)
		emit_signal("detector_entrada", direccion)
	elif event.is_action_pressed("ui_right"):
		var direccion: Vector2 = Vector2(1, 0)
		emit_signal("detector_entrada", direccion)
	elif event.is_action_pressed("ui_down"):
		var direccion: Vector2 = Vector2(0, 1)
		emit_signal("detector_entrada", direccion)
	elif event.is_action_pressed("ui_left"):
		var direccion: Vector2 = Vector2(-1, 0)
		emit_signal("detector_entrada", direccion)