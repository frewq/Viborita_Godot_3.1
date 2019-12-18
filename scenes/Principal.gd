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
	grilla.colocar_entidad_posicion_random(jugador)
	
	var comida_instancia: Node2D = escena_comer.instance() as Node2D
	add_child(comida_instancia)
	grilla.colocar_entidad_posicion_random(comida_instancia)

func _on_Vibora_mover_activado(entidad: Node2D, direccion: Vector2) -> void:
	grilla.mover_entidad_en_direccion(entidad, direccion)

func _on_Grilla_hacia_morir():
	borrar_entidad_grupo("comida")
	borrar_entidad_grupo("jugador")
	
	setup_entidades()

func borrar_entidad_grupo(nombre: String) -> void:
	var entidades: Array = get_tree().get_nodes_in_group(nombre)
	for entidad in entidades:
		entidad.queue_free()