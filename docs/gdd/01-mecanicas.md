# 01 — Mecánicas

Dos grupos: lo que el jugador descubre solo en los primeros segundos, y lo que
el juego tiene que enseñarle sin texto.

---

## Visibles (las sabes casi al empezar)

### Movimiento
[DECIDIDO] 8 direcciones con las teclas habituales. [CÓDIGO]
`entities/chicken/chicken.gd` — `move_speed = 200 px/s`, orden de dibujado por
`z_index = position.y`.

### Cabeceo / picar
[DECIDIDO] Un botón mueve la cabeza de la gallina. Es **lo único que el juego
te deja claro de salida**. A partir de ahí, el contexto cambia lo que hace:

| Contexto | Resultado |
| --- | --- |
| Cerca de un objeto activable | Lo pica (botones, palancas, campanas, el tractor…) |
| Cerca de un objeto cogible, con el pico libre | Lo coge |
| Llevando un objeto | Lo suelta |
| En el aire / sin nada cerca | Cabeceo en vacío (feedback puro) |

Regla derivada: **con un objeto en el pico no puedes picar**. Hay que soltar
para interactuar. Esto ya es material de puzzle (ver las llaves del tractor).

---

## Ocultas (el juego tiene que enseñarlas)

### Volar / planear
[DECIDIDO] Pulsando **muchas veces seguidas** el botón, la gallina se eleva y
planea un poco. Sirve para salvar obstáculos: el río del camino principal es el
caso claro.
[CÓDIGO] Ya implementado: cada pulsación suma `0.5` a `button_charge`, que
decae `1.0` por segundo; al pasar de `1.0` se dispara `fly()` con impulso
proporcional. Altura simulada con `z_offset` sobre el sprite. En números: **tres
toques en menos de 0,5 s**.

**[DECIDIDO] Volar no debe descubrirse por accidente.** Si el jugador se pone a
volar por machacar el botón delante de un objeto picable, el secreto se quema
gratis y se pierde la gracia. De ahí que haya que separar el gesto de volar del
de picar → ver el choque de gestos en [02-controles.md](02-controles.md), que es
hoy el bloqueante nº 1.

**[DECIDIDO] Lo enseña otra gallina.** En algún sitio hay una gallina haciendo el
gesto: la ves mover la cabeza muy rápido y despegar, y de ahí sacas qué hay que
hacer. [ABIERTO] Dónde está, sabiendo que tiene que ser antes del río.

Esto es importante por lo que resuelve: **el gesto se ve**. Como el botón mueve
la cabeza de la gallina, la cabeza del maestro es la representación visible de lo
que tú tienes que hacer con el dedo. Cabeza rápida = toques rápidos. Ver
[07-ensenanza-sin-texto.md](07-ensenanza-sin-texto.md).

### Poner un huevo
[DECIDIDO] **Manteniendo pulsado** ese mismo botón un buen rato.
[CÓDIGO] `time_to_lay_egg = 3.0 s`; a mitad de ese tiempo la gallina entra en
animación `lay_egg`, al terminar emite `SignalBus.lay_egg(position)` y
`EggsManager` instancia el huevo.

Usos del huevo:
- Distraer a la serpiente (se aparta y te deja pasar).
- Freírlo en una zona caliente. El huevo frito es comida: el perro se lo come.
- [ABIERTO] Apretar el acelerador del tractor (ver [04-puzzles.md](04-puzzles.md)).

### Visión especial
[DECIDIDO] Las gallinas ven muy bien. Al activarla:
- Las zonas muy oscuras se vuelven legibles.
- Se ven **puntos calientes**, con distintos grados de temperatura.

[DECIDIDO] **Se aprende en el primer claro**: la primera pista que dan los
claros es siempre cómo activar la visión especial (ver más abajo).

Usos confirmados: atravesar/leer zonas oscuras (la sala de los cuervos, el
laberinto del camino principal) y localizar zonas calientes donde freír huevos.
[ABIERTO] Qué más aporta leer la temperatura además de encontrar sitios donde
freír.
[ABIERTO] ¿Es un toggle, se mantiene pulsado, consume algo? Ver
[02-controles.md](02-controles.md).
Implementación prevista: shader.

### Campanas a ritmo
[DECIDIDO] Por el mapa hay campanas (un palo con una campana). Picarlas sin más
no hace nada útil. Picarlas **siguiendo un ritmo concreto** llama a un cuervo,
que hace una cosa u otra **según la campana**.
- Si esa campana ya cumplió su función, el cuervo viene igual, da una vuelta y
  se va. (Feedback de "esto ya estaba hecho".)
- El ritmo se aprende viendo a dos cuervos jugar en una sala oscura.
[ABIERTO] Cuántas campanas hay y qué hace cada una (solo está cerrada la del
gallinero de ponedoras).

### Claros
[DECIDIDO] En ciertas zonas despejadas, si te quedas **parado un buen rato**,
la vista cambia al cielo y aparecen mensajes que ayudan a avanzar.
- Se aprende viendo a otra gallina sentarse en un claro y ponérsele los ojos en
  blanco, con un claro practicable muy cerca.
- **[DECIDIDO] La primera pista es siempre la visión especial.** Sea cual sea el
  claro al que llegues primero, lo que te explica es cómo activarla. Es el
  arranque de toda la cadena larga de conocimiento.
- **[DECIDIDO] Basta con que un claro esté abierto y accesible**, nada más
  cruzar la carretera. Es el claro-tutorial, y es el único que tiene que estar
  a la vista y sin ninguna traba.
- **[DECIDIDO] Los demás claros van medio cerrados** o en sitios menos
  accesibles. Pueden pedir mecánicas ya aprendidas, con un límite (ver la regla
  de circularidad en [05-progresion.md](05-progresion.md)): ningún claro puede
  estar cerrado detrás de la mecánica que él mismo enseña.
- [DECIDIDO, versión actual] Varios claros repartidos por el mapa, cada uno con
  su tipo de pista (en vez de una lista lineal de pistas en un solo claro).
- [ABIERTO] Cuántos y dónde. La cuenta de pistas que el diseño necesita está en
  [05-progresion.md](05-progresion.md): salen cuatro, no veinte.
