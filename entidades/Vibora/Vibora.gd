extends Node2D

class_name Vibora

onready var direccion: Vector2 = Vector2() #tipado estático

func _ready():
	$ComponenteEntradaJugador.connect("detector_entrada", self,"_on_ComponenteEntradaJugador_input_detected")

func _on_ComponenteEntradaJugador_input_detected(nueva_direccion) -> void:
	if nueva_direccion != direccion * -1: #Evita que la vibora pueda ir en reversa
		direccion = nueva_direccion
		print(direccion)
