extends Node2D

class_name Vibora

signal mover_activado(entidad, direccion)

onready var direccion: Vector2 = Vector2() #tipado estático
onready var puede_mover: bool = false

func _ready():
	$ComponenteEntradaJugador.connect("detector_entrada", self,"_on_ComponenteEntradaJugador_input_detected")

func _process(delta):
	if direccion != Vector2() and puede_mover:
		emit_signal("mover_activado", self, direccion)
		
		puede_mover = false
		$MovimientoRetraso.start()

func _on_ComponenteEntradaJugador_input_detected(nueva_direccion) -> void:
	if nueva_direccion != direccion * -1: #Evita que la vibora pueda ir en reversa
		direccion = nueva_direccion
		print(direccion)


func _on_MovimientoRetraso_timeout() -> void:
	puede_mover = true
