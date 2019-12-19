extends Node2D

class_name Vibora

signal mover_activado(entidad, direccion)
signal segmento_cola_creada(segmento, segmento_posicion)
signal segmento_cuerpo_mover_activado(segmento, segmento_posicion)
signal cambio_tamano(largo)

onready var direccion: Vector2 = Vector2() #tipado estático
onready var puede_mover: bool = false
onready var segmentos_cuerpo: Array = [self]

const escena_cola = preload("res://entidades/Cola/Cola.tscn")

func _ready():
	$ComponenteEntradaJugador.connect("detector_entrada", self,"_on_ComponenteEntradaJugador_input_detected")
	emit_signal("cambio_tamano", segmentos_cuerpo.size())

func _process(delta):
	if direccion != Vector2() and puede_mover:
		var antigua_posicion_de_segmento_en_frente: Vector2 = self.position
		emit_signal("mover_activado", self, direccion)
		emit_signal("cambio_tamano", segmentos_cuerpo.size())
		if segmentos_cuerpo.size() > 1:
			for i in range(1, segmentos_cuerpo.size()):
				var temp_pos: Vector2 = segmentos_cuerpo[i].position
				emit_signal("segmento_cuerpo_mover_activado", segmentos_cuerpo[i], antigua_posicion_de_segmento_en_frente)
				antigua_posicion_de_segmento_en_frente = temp_pos
		puede_mover = false
		$MovimientoRetraso.start()

func comer() -> void:
	var segmento_cola: Node2D = escena_cola.instance() as Node2D
	segmentos_cuerpo.append(segmento_cola)
	emit_signal("segmento_cola_creada", segmento_cola, segmentos_cuerpo[-2].position)

func _on_ComponenteEntradaJugador_input_detected(nueva_direccion) -> void:
	if nueva_direccion != direccion * -1: #Evita que la vibora pueda ir en reversa
		direccion = nueva_direccion
		print(direccion)

func _on_MovimientoRetraso_timeout() -> void:
	puede_mover = true
	