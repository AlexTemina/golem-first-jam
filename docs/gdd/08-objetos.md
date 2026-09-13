# 08 — Objetos

## Reglas

[DECIDIDO]
- Se cogen y se sueltan con el botón de picar, estando cerca.
- **Con un objeto en el pico no se puede picar.** Hay que soltarlo primero.
- Se llevan de uno en uno (un pico, un objeto).
- [ABIERTO] ¿Se pueden llevar objetos de una run a otra, o vuelven a su sitio al
  reiniciar? Por coherencia con "puzzles de estado", lo razonable es que un
  objeto ya usado se quede donde se usó.

## Inventario del juego

| Objeto | Dónde está | Para qué sirve |
| --- | --- | --- |
| Llaves | Colgadas en la pared, dentro del parking | Arrancar el tractor |
| Huevo | Lo pone la gallina | Serpiente, freírlo para el perro, ¿acelerador? |

Eso es todo lo que hay cerrado hoy.

## Lo que falta

[ABIERTO — petición explícita de diseño] Hacen falta **más objetos repartidos
por el mapa, y con más de un sitio donde usarlos**. La idea es que un objeto no
sea una llave de un solo cerrojo, sino algo que valga en varios puntos.

Criterios que ya impone el diseño, para cuando se rellenen:
- Llevar un objeto te quita la capacidad de picar ⇒ cualquier objeto es también
  una **limitación** mientras lo llevas. Eso ya es material de puzzle por sí
  solo (trayectos donde hay que elegir qué llevas).
- El objeto tiene que leerse en pixel art a 320×180, en el pico de una gallina.
- Un objeto que cruce edificios obliga al jugador a hacer rutas, y las rutas
  cuestan tiempo de perro.
