# 06 — El bucle, el perro y el tiempo

## El perro

Está sentado fuera del gallinero inicial, esperando. No te persigue: **es un
reloj con forma de perro**.

- Mientras estás dentro del gallinero inicial, el tiempo **no** corre.
- Al salir, arranca la cuenta.
- Cuando se acaba: el perro te caza, se ve una imagen de la captura y vuelves al
  principio.

## La cadena

El HUD es una **cadena que se va rompiendo** con el tiempo. Es el único
indicador temporal.

[CÓDIGO] `entities/time_chain/time_chain.gd`: `max_time` (hoy **12 s**,
placeholder) y un sprite de **4 frames** que avanza según el tiempo restante. Al
agotarse emite `SignalBus.game_time_over`, y `test_farm.gd` hace fundido a negro
y recarga la escena.

[ABIERTO] Duración objetivo: se habla de **1–2 minutos**, posiblemente más.
[ABIERTO] La imagen/cinemática de captura del perro no está hecha.
[ABIERTO] Se barajó que el perro diera **más tiempo cuanto más lejos estés de
él**. Decisión actual: **tiempo único para todo**, y ya se verá.

## Qué persiste entre runs

| Tipo | Ejemplos | ¿Persiste? |
| --- | --- | --- |
| Conocimiento del jugador | Volar, huevos, visión, ritmo | Siempre (está en su cabeza) |
| Puzzles de estado | Puerta del parking, tractor estrellado, puerta de las ponedoras | Sí |
| Puzzles de ejecución | Río, serpiente, laberinto, huevo frito para el perro | No |

Efecto buscado: cada run es más corta que la anterior, no porque el personaje
sea más fuerte, sino porque el mundo se va quedando abierto y el jugador ya no
duda.

**El bucle es aprender y reiniciar, no ir y volver.** Una run sirve para
descubrir una cosa; el perro te caza; empiezas de nuevo sabiéndola. Los sitios
que enseñan (cuervos, ponedoras, gallina sentada) son de **un solo uso en toda
la partida**: cuando ya te han enseñado, dejan de importar. No hay que
dimensionar el tiempo para que quepan dos zonas del mapa en la misma run.

## La run óptima

Vale la pena tenerla escrita, porque es contra la que hay que tunear el
temporizador. Con todos los puzzles de estado ya hechos y el jugador sabiéndolo
todo, la partida ganadora **no visita a ningún maestro**:

1. Salir del gallinero.
2. Poner un huevo y llevarlo a la zona caliente de al lado del perro.
3. Dárselo frito → tiempo suficiente para lo que queda.
4. Cruzar la carretera, que ya está cortada por el tractor.
5. Camino principal: serpiente (huevo), río (volar), laberinto (visión),
   campana (ritmo).
6. Salida.

Ni claro, ni cuervos, ni ponedoras, ni tractor: todo eso ya pasó en runs
anteriores. Eso son los 1–2 minutos objetivo.

## Tensión conocida

El temporizador empuja a ir rápido; el descubrimiento empuja a experimentar. En
las primeras runs el jugador **necesita** trastear, que es exactamente cuando el
perro más le aprieta.

Ojo con confundir esto con un problema: que una run se vaya entera en descubrir
una sola cosa **es el diseño funcionando**. El problema sería lo contrario —
que el jugador no llegue ni a descubrir una cosa por run, y sienta que el perro
le corta antes de enterarse de nada.

Palancas ya identificadas para regularlo, si al testear pica:
- Subir `max_time` global.
- Escalar el tiempo con la distancia al perro (idea ya barajada, aparcada).
- El huevo frito, que es tiempo extra dentro de la run.

Por ahora se deja fijo y se ajusta con playtest. Conviene medir dos cosas al
probar: cuánto dura una run **perfecta** y cuánto dura la run de un jugador que
está probando cosas.
