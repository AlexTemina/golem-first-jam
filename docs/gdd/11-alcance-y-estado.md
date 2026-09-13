# 11 — Alcance y estado

## Qué está implementado hoy [CÓDIGO]

| Pieza | Estado |
| --- | --- |
| Movimiento 8 direcciones | Hecho |
| Picar (animación + estado) | Hecho; **sin detección de objetos cercanos** |
| Volar por pulsaciones repetidas | Hecho, con altura simulada y gravedad |
| Poner huevo manteniendo (3 s) | Hecho; el huevo se instancia en el mundo |
| Obstáculos que se activan/desactivan al volar | Hecho (`obstacles_manager`) |
| Cadena de tiempo + reinicio de escena | Hecho (12 s placeholder, fundido a negro) |
| SignalBus, capas de arquitectura | En pie |
| Sonido de huevo y de vuelo | Hecho |
| Cámara (Phantom Camera) | Integrada |

## Qué falta, por orden de riesgo

1. **Claros** (cambio de vista al cielo + pictogramas de pista) — son la raíz
   del grafo: sin ellos no se aprende nada de la cadena larga. Ver
   [05-progresion.md](05-progresion.md).
2. **Visión especial** (shader + zonas oscuras + puntos calientes).
3. **Sistema de coger/soltar objetos** y detección de interactuables al picar.
4. **Campanas con ritmo + cuervos** (detección de patrón, IA simple del cuervo).
5. **La gallina sentada** del claro-tutorial: su animación y su colocación son
   trabajo crítico, no decorado.
6. **La secuencia del tractor**: sube de prioridad al ser el prólogo obligatorio.
   Si falla, el jugador no ve nada del resto del juego.
6. **Persistencia de puzzles entre runs** (hoy `reload_current_scene()` borra
   todo; hace falta un estado global que sobreviva al reinicio).
7. Mapa real: granja, tres edificios, carretera con coches, bosque.
8. NPCs: perro, cuervos, ponedoras, serpiente, gallina sentada, gallina que vuela.
9. Secuencia del tractor (animación no controlable + choque).
10. Arte y audio definitivos.

> El punto 6 es el que más fácil se pasa por alto: **el diseño entero depende de
> que ciertos puzzles se queden hechos**, y hoy el reinicio recarga la escena y
> lo borra todo. Hace falta un autoload de progreso en `states/`.

## ¿Cuánto dura el juego?

Estimación, contando los gates de conocimiento actuales (picar, coger/soltar,
volar, huevos, visión, ritmo, claros = 7) y los ~14 puzzles:

| Perfil de jugador | Duración |
| --- | --- |
| Run perfecta sabiéndolo todo | **1–2 minutos** (es el objetivo declarado) |
| Primera partida completa, jugador nuevo | **25–45 minutos**, en unas 10–25 runs |
| Jugador que se atasca en el tractor | No ve nada del juego |

Para una jam está bien: 30 minutos es una duración muy sana para que alguien lo
termine y vote. El riesgo no es la duración, es la **varianza**: en juegos de
descubrimiento, el mismo diseño puede dar 20 minutos o abandono a los 8, y todo
depende de cuántos maestros y claros haya y de lo pronto que aparezcan.

Palanca de seguridad, si en el playtest la gente se atasca: **más claros y más
gallinas sentadas cerca del principio**, que es lo más barato de añadir y no
toca el resto del diseño.

## Recorte de emergencia

Si va justo de tiempo, el orden en que menos duele cortar:

1. Zonas calientes extra (todas menos la del perro).
2. Usos secundarios del huevo.
3. Campanas extra (dejar solo la de las ponedoras y la del camino).
4. El laberinto oscuro del camino principal (se puede reducir a una sala).

Lo que **no** se puede cortar sin romper el juego: el tractor (abre el mapa), la
cadena visión→ritmo→huevos, el huevo frito del perro y el camino final.
