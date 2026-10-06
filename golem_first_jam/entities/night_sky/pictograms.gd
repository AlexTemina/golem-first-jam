class_name Pictograms extends Node

# Cada letra contiene uno o varios trazos.
# Cada trazo es un Array[Vector2i].
#
# Coordenadas aproximadas:
#   x: 0..6
#   y: 0..10
#
# Para dibujar una letra:
# for trazo in ALFABETO["A"]:
#     for i in range(trazo.size() - 1):
#         draw_line(trazo[i], trazo[i + 1], Color.WHITE, 1.0)


const ALPHABET = {
	"A": [
		[
			Vector2i(0, 10),
			Vector2i(3, 0),
			Vector2i(6, 10)
		],
		[
			Vector2i(1, 6),
			Vector2i(5, 6)
		]
	],

	"B": [
		[
			Vector2i(0, 10),
			Vector2i(0, 0),
			Vector2i(4, 0),
			Vector2i(6, 2),
			Vector2i(6, 4),
			Vector2i(4, 5),
			Vector2i(0, 5),
			Vector2i(4, 5),
			Vector2i(6, 6),
			Vector2i(6, 8),
			Vector2i(4, 10),
			Vector2i(0, 10)
		]
	],

	"C": [
		[
			Vector2i(6, 1),
			Vector2i(5, 0),
			Vector2i(2, 0),
			Vector2i(0, 2),
			Vector2i(0, 8),
			Vector2i(2, 10),
			Vector2i(5, 10),
			Vector2i(6, 9)
		]
	],

	"D": [
		[
			Vector2i(0, 10),
			Vector2i(0, 0),
			Vector2i(3, 0),
			Vector2i(6, 3),
			Vector2i(6, 7),
			Vector2i(3, 10),
			Vector2i(0, 10)
		]
	],

	"E": [
		[
			Vector2i(6, 0),
			Vector2i(0, 0),
			Vector2i(0, 10),
			Vector2i(6, 10)
		],
		[
			Vector2i(0, 5),
			Vector2i(5, 5)
		]
	],

	"F": [
		[
			Vector2i(0, 10),
			Vector2i(0, 0),
			Vector2i(6, 0)
		],
		[
			Vector2i(0, 5),
			Vector2i(5, 5)
		]
	],

	"G": [
		[
			Vector2i(6, 2),
			Vector2i(5, 0),
			Vector2i(2, 0),
			Vector2i(0, 2),
			Vector2i(0, 8),
			Vector2i(2, 10),
			Vector2i(5, 10),
			Vector2i(6, 8),
			Vector2i(6, 6),
			Vector2i(3, 6)
		]
	],

	"H": [
		[
			Vector2i(0, 0),
			Vector2i(0, 10)
		],
		[
			Vector2i(6, 0),
			Vector2i(6, 10)
		],
		[
			Vector2i(0, 5),
			Vector2i(6, 5)
		]
	],

	"I": [
		[
			Vector2i(1, 0),
			Vector2i(5, 0)
		],
		[
			Vector2i(3, 0),
			Vector2i(3, 10)
		],
		[
			Vector2i(1, 10),
			Vector2i(5, 10)
		]
	],

	"J": [
		[
			Vector2i(1, 0),
			Vector2i(6, 0)
		],
		[
			Vector2i(4, 0),
			Vector2i(4, 8),
			Vector2i(3, 10),
			Vector2i(1, 10),
			Vector2i(0, 8)
		]
	],

	"K": [
		[
			Vector2i(0, 0),
			Vector2i(0, 10)
		],
		[
			Vector2i(6, 0),
			Vector2i(0, 5),
			Vector2i(6, 10)
		]
	],

	"L": [
		[
			Vector2i(0, 0),
			Vector2i(0, 10),
			Vector2i(6, 10)
		]
	],

	"M": [
		[
			Vector2i(0, 10),
			Vector2i(0, 0),
			Vector2i(3, 5),
			Vector2i(6, 0),
			Vector2i(6, 10)
		]
	],

	"N": [
		[
			Vector2i(0, 10),
			Vector2i(0, 0),
			Vector2i(6, 10),
			Vector2i(6, 0)
		]
	],

	"O": [
		[
			Vector2i(2, 0),
			Vector2i(4, 0),
			Vector2i(6, 2),
			Vector2i(6, 8),
			Vector2i(4, 10),
			Vector2i(2, 10),
			Vector2i(0, 8),
			Vector2i(0, 2),
			Vector2i(2, 0)
		]
	],

	"P": [
		[
			Vector2i(0, 10),
			Vector2i(0, 0),
			Vector2i(4, 0),
			Vector2i(6, 2),
			Vector2i(6, 4),
			Vector2i(4, 5),
			Vector2i(0, 5)
		]
	],

	"Q": [
		[
			Vector2i(2, 0),
			Vector2i(4, 0),
			Vector2i(6, 2),
			Vector2i(6, 8),
			Vector2i(4, 10),
			Vector2i(2, 10),
			Vector2i(0, 8),
			Vector2i(0, 2),
			Vector2i(2, 0)
		],
		[
			Vector2i(4, 7),
			Vector2i(7, 11)
		]
	],

	"R": [
		[
			Vector2i(0, 10),
			Vector2i(0, 0),
			Vector2i(4, 0),
			Vector2i(6, 2),
			Vector2i(6, 4),
			Vector2i(4, 5),
			Vector2i(0, 5)
		],
		[
			Vector2i(3, 5),
			Vector2i(6, 10)
		]
	],

	"S": [
		[
			Vector2i(6, 1),
			Vector2i(4, 0),
			Vector2i(2, 0),
			Vector2i(0, 2),
			Vector2i(0, 4),
			Vector2i(2, 5),
			Vector2i(4, 5),
			Vector2i(6, 6),
			Vector2i(6, 8),
			Vector2i(4, 10),
			Vector2i(2, 10),
			Vector2i(0, 9)
		]
	],

	"T": [
		[
			Vector2i(0, 0),
			Vector2i(6, 0)
		],
		[
			Vector2i(3, 0),
			Vector2i(3, 10)
		]
	],

	"U": [
		[
			Vector2i(0, 0),
			Vector2i(0, 8),
			Vector2i(2, 10),
			Vector2i(4, 10),
			Vector2i(6, 8),
			Vector2i(6, 0)
		]
	],

	"V": [
		[
			Vector2i(0, 0),
			Vector2i(3, 10),
			Vector2i(6, 0)
		]
	],

	"W": [
		[
			Vector2i(0, 0),
			Vector2i(1, 10),
			Vector2i(3, 5),
			Vector2i(5, 10),
			Vector2i(6, 0)
		]
	],

	"X": [
		[
			Vector2i(0, 0),
			Vector2i(6, 10)
		],
		[
			Vector2i(6, 0),
			Vector2i(0, 10)
		]
	],

	"Y": [
		[
			Vector2i(0, 0),
			Vector2i(3, 5),
			Vector2i(6, 0)
		],
		[
			Vector2i(3, 5),
			Vector2i(3, 10)
		]
	],

	"Z": [
		[
			Vector2i(0, 0),
			Vector2i(6, 0),
			Vector2i(0, 10),
			Vector2i(6, 10)
		]
	]
}

static func get_letter_lines(letter: String) -> Array:
	return ALPHABET.get(letter, [])
