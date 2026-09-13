# 04 — Puzzles

Dos tipos, y la distinción es la que sostiene el bucle del juego:

- **De estado** — una vez resueltos, el mundo se queda así. En la siguiente run
  ya están hechos.
- **De ejecución** — hay que volver a hacerlos cada run (cruzar el río, esquivar
  a la serpiente, atravesar el laberinto).

---

## Cadena del tractor (abrir la carretera)

El puzzle grande de la granja. Pasos [DECIDIDO]:

1. Picar el **botón** de la puerta del edificio del parking → se abre.
2. Entrar y **coger las llaves** de la pared.
3. Ir al tractor. **Soltar las llaves** para tener el pico libre.
4. **Picar el tractor** → se abre su puerta.
5. Entrar con las llaves.
6. [ABIERTO] ¿Poner un huevo para que apriete el acelerador? Duda real: puede
   ser demasiado complejo de leer visualmente.
7. Animación no controlable: el tractor arranca, sale disparado y **choca contra
   la parada de autobús**, quedándose cruzado en la carretera.
8. Los coches frenan. La carretera queda **cruzable para siempre**.

Tipo: **de estado**. Si intentas cruzar antes, la gallina se espanta y retrocede.

**Es también el prólogo obligatorio del juego**: el claro-tutorial está al otro
lado de la carretera, así que hasta que el tractor no se estrella no se puede
aprender nada de la cadena larga. Ver [05-progresion.md](05-progresion.md).

---

## Tabla de puzzles

| # | Puzzle | Dónde | Exige saber | Exige objeto | Resultado | Persiste |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | Salir del gallinero | Gallinero inicial | — | — | Empieza el tiempo | — |
| 2 | Puerta del parking | Granja | Picar | — | Puerta abierta | Sí |
| 3 | Llaves | Interior parking | Coger/soltar | — | Llaves en mano | Sí* |
| 4 | Tractor | Junto al parking | Picar + soltar (+ ¿huevo?) | Llaves | Carretera abierta | Sí |
| 5 | Sala de los cuervos | Granja, zona oscura | Visión | — | Aprendes el ritmo | Conocimiento |
| 6 | Puerta de las ponedoras | Granja | Ritmo de campana | — | Puerta abierta | Sí |
| 7 | Las ponedoras | Interior ponedoras | — | — | Aprendes a poner huevos | Conocimiento |
| 8 | Huevo frito para el perro | Zona caliente junto al perro | Poner huevo + zona caliente | Huevo | **Más tiempo esa run** | No |
| 9 | Claro-tutorial | Bosque, nada más cruzar la carretera | — | — | Aprendes los claros **y la visión especial** | Conocimiento |
| 10 | Serpiente | Camino principal | Poner huevo | Huevo | Pasas | No |
| 11 | Río | Camino principal | Volar | — | Pasas | No |
| 12 | Laberinto oscuro | Camino principal | Visión | — | Pasas | No |
| 13 | Campana del camino | Camino principal | Ritmo | — | Cuervo abre el paso | [ABIERTO] |
| 14 | Salida final | Final del camino | Todas | — | **Fin del juego** | — |

\* [ABIERTO] Si las llaves siguen puestas en el tractor tras usarlo, el puzzle 3
no hay que rehacerlo. Si el tractor ya está estrellado, da igual.

---

## El puzzle que no parece un puzzle

**El huevo frito del perro** es el único puzzle de ejecución obligatorio y es el
que hace funcionar el bucle: aunque sepas hacerlo todo perfecto, **no te da
tiempo a escapar** si no le das de comer al perro primero. Es la pieza que
convierte "sé hacerlo todo" en "sé en qué orden hacerlo todo".

Implicación: hay que tunearlo con cuidado. Si sobra tiempo, se vuelve opcional y
el bucle pierde el remate; si falta, la run perfecta se vuelve un speedrun
frustrante.

---

## Huecos declarados

[ABIERTO] Faltan puzzles por inventar en estas ranuras:
- Más usos del huevo (solo hay 2).
- Más usos de la visión (solo hay 2).
- Más objetos y sitios donde usarlos (ver [08-objetos.md](08-objetos.md)).
- Gating de entrada a cada puzzle-que-enseña (ver [05-progresion.md](05-progresion.md)).
