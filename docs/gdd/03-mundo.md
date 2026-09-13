# 03 — Mundo

## Estructura general

Tres franjas, de abajo arriba:

```
              [ BOSQUE ]          ← camino principal y salida
    ══════════════════════════    ← CARRETERA (coches pasando)
              [ GRANJA ]          ← punto de partida
```

La **carretera** separa la granja del bosque y es el gran muro de la primera
mitad: mientras pasen coches, no se cruza (la gallina se espanta y retrocede).

## Granja

Zona de partida. Tres edificios entrables [ABIERTO: podría haber más]:

### 1. Gallinero inicial
Donde empiezas, con otras gallinas. Se sale por un agujerito.
[ABIERTO] Si hace falta un puzzle para salir o basta con encontrar el agujero.
**Dentro del gallinero el tiempo no corre.** El cronómetro arranca al salir.

### 2. Gallinero de las ponedoras
Puerta cerrada, con una **campana al lado**. Tocando la campana al ritmo, un
cuervo abre la puerta. Dentro, las gallinas ponedoras te enseñan a poner huevos.

### 3. Edificio con parking
Tiene una zona de aparcamiento. La puerta se abre picando un **botón** desde
fuera. Dentro, unas **llaves colgadas en la pared**.

### Exterior de la granja

- **El perro**: sentado fuera, esperando su momento. Mientras estás dentro del
  gallinero inicial no pasa nada.
- **Zona caliente junto al perro**: aquí se fríen los huevos que se le dan.
- **El tractor**: parado junto al parking, mirando hacia la carretera.
- **La parada de autobús**: al otro lado de la carretera, justo enfrente del
  tractor.
- **Otras zonas calientes** repartidas por el mapa. [ABIERTO] Para qué sirven
  las demás.
- **Otros claros**, medio cerrados o poco accesibles. [ABIERTO] Dónde.
- **La gallina que vuela**: el maestro del vuelo. [ABIERTO] Dónde, sabiendo que
  tiene que estar antes del río del camino principal.
- **Sala oscura de los cuervos**: dos cuervos jugando; uno pica la campana a
  ritmo y el otro ejecuta la acción. Requiere visión especial para verla.
  [ABIERTO] Dónde está exactamente.

## Bosque

### El claro-tutorial
[DECIDIDO] **Nada más cruzar la carretera**, abierto y accesible, con la gallina
sentada al lado. Es la puerta de entrada a todo el conocimiento oculto del
juego: aquí se aprenden los claros y, con ellos, la visión especial.

Consecuencia estructural: **la carretera es el gate de todo**. Hasta que el
tractor no la cruza, el jugador no tiene forma de aprender nada de la cadena
larga. Ver [05-progresion.md](05-progresion.md).

### Camino principal

El "examen". Una secuencia de obstáculos, cada uno pidiendo una mecánica
distinta. Orden [ABIERTO], contenido confirmado:

| Obstáculo | Mecánica que exige |
| --- | --- |
| Serpiente | Poner un huevo a su lado para que se aparte |
| Río | Volar / planear |
| Zona oscura tipo laberinto | Visión especial |
| Campana | Ritmo → cuervo |
| Claro (quizá) | Pista para el siguiente paso |

Al final del camino: **escapas y se acaba el juego**.

## Densidad pendiente

[ABIERTO] El diseño actual usa cada mecánica en muy pocos sitios. Falta repartir
más usos, en concreto:
- Más zonas donde los huevos sirvan para algo (hoy: serpiente + perro).
- Más zonas oscuras que pidan visión (hoy: cuervos + laberinto).
- Mini-antesalas: pequeños obstáculos que exijan la mecánica **A** justo antes
  del puzzle que enseña la mecánica **B**, para encadenar el aprendizaje. Ver
  [05-progresion.md](05-progresion.md).
