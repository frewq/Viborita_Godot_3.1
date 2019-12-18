extends Node

const escena_comer = preload("res://entidades/Comida/Comida.tscn")
const escena_vibora = preload("res://entidades/Vibora/Vibora.tscn")

onready var grilla: Grilla = get_node("Grilla") as Grilla

var jugador: Node2D

func _ready():
	randomize()
	setup_entidades()

func setup_entidades() -> void:
	jugador = escena_vibora.instance() as Node2D
	jugador.connect("mover_activado", self, "_on_Vibora_mover_activado")
	add_child(jugador)
	jugador.connect("segmento_cola_creada",self, "_on_Vibora_segmento_cola_creada")
	jugador.connect("segmento_cuerpo_mover_activado", self, "on_Vibora_segmento_cuerpo_mover_activado")
	grilla.colocar_entidad_posicion_random(jugador)
	
	setup_entidad_comida()

func setup_entidad_comida() -> void:
	var comida_instancia: Node2D = escena_comer.instance() as Node2D
	add_child(comida_instancia)
	grilla.colocar_entidad_posicion_random(comida_instancia)

func _on_Vibora_mover_activado(entidad: Node2D, direccion: Vector2) -> void:
	grilla.mover_entidad_en_direccion(entidad, direccion)

func _on_Grilla_hacia_morir() -> void:
	borrar_entidad_grupo("comida")
	borrar_entidad_grupo("jugador")
	
	setup_entidades()

func borrar_entidad_grupo(nombre: String) -> void:
	var entidades: Array = get_tree().get_nodes_in_group(nombre)
	for entidad in entidades:
		entidad.queue_free()

func _on_Grilla_mover_hacia_comida(entidad_comida: Node2D, entidad:Node2D) -> void:
	if entidad.has_method("comer"):
		entidad.comer()
		entidad_comida.queue_free()
		setup_entidad_comida()


func _on_Vibora_segmento_cola_creada(segmento: Node2D, segmento_posicion:Vector2) -> void:
	add_child(segmento)
	grilla.colocar_entidad(segmento, grilla.world_to_map(segmento_posicion))

func on_Vibora_segmento_cuerpo_mover_activado(segmento: Node2D, segmento_posicion: Vector2) -> void:
	grilla.mover_entidad_a_posicion(segmento, segmento_posicion)


