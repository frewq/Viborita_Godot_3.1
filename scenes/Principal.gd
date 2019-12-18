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
	add_child(jugador)
	grilla.colocar_entidad_posicion_random(jugador)
	
	var comida_instancia: Node2D = escena_comer.instance() as Node2D
	add_child(comida_instancia)
	grilla.colocar_entidad_posicion_random(comida_instancia)