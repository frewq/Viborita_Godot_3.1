extends Node2D

onready var grilla: Grilla = get_parent() as Grilla

export var linea_color: Color
export var linea_grosor = 1

func _draw() -> void:
	for x in range(grilla.grilla_tamano.x):
		var punto_inicio: Vector2 = Vector2(x * grilla.cell_size.x, 0)
		var punto_final: Vector2 = Vector2(x * grilla.cell_size.x, grilla.grilla_tamano.y * grilla.cell_size.y)
		draw_line(punto_inicio, punto_final, linea_color, linea_grosor)
		
	for y in range(grilla.grilla_tamano.y):
		var punto_inicio: Vector2 = Vector2(0, y * grilla.cell_size.y)
		var punto_final: Vector2 = Vector2(grilla.grilla_tamano.x * grilla.cell_size.x, y * grilla.cell_size.y)
		draw_line(punto_inicio, punto_final, linea_color, linea_grosor)