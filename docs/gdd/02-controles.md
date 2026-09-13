# 02 — Controles

## Estado actual del proyecto

[CÓDIGO] Acciones en `project.godot`:

| Acción | Tecla |
| --- | --- |
| `up` / `down` / `left` / `right` | Flechas |
| `a_button` | **Q** |
| `b_button` | **W** (sin uso todavía) |

> Nota: `chicken.gd` lee hoy `ui_up` / `ui_down` / `ui_left` / `ui_right`, no
> las acciones `up`/`down`/`left`/`right` definidas en el proyecto. Funciona por
> los mapeos por defecto de Godot, pero conviene unificarlo.

[CÓDIGO] Todo cuelga hoy de `a_button`, distinguido por **cómo** lo pulsas:

| Gesto | Acción | Detalle |
| --- | --- | --- |
| Toque | Picar | `peck()` |
| Toques repetidos | Volar | `button_charge > 1.0`, decae a 1.0/s |
| Mantener 3 s | Poner huevo | `time_to_lay_egg` |

Es exactamente la idea de diseño: **un botón, tres significados**, y el jugador
tiene que descubrir dos de ellos.

## El choque de gestos [BLOQUEANTE]

**El problema:** si picas de seguido, te pones a volar sin querer. Y el coste no
es solo el input no deseado: **quema uno de los secretos del juego gratis**. Que
el jugador tropiece con el vuelo no es descubrirlo, y ahí se pierde la gracia.

### Cuánto de fácil es hoy, exactamente [CÓDIGO]

`chicken.gd` lleva un contador `button_charge`:

| Regla | Valor |
| --- | --- |
| Cada pulsación suma | `+0.5` |
| El contador decae | `1.0` por segundo |
| Vuela cuando pasa de | `> 1.0` |

De ahí sale el número que importa: **tres toques en menos de 0,5 segundos**. Con
dos no despega nunca (el máximo que alcanzan es exactamente 1.0, y el umbral es
estricto). O sea, unas 6 pulsaciones por segundo: rápido, pero es justo la
cadencia a la que la gente machaca un botón cuando está probando cosas contra un
objeto del escenario.

> Corrección respecto a versiones anteriores de este documento: decía "dos
> toques rápidos", y son tres.

### Por qué hoy no se puede distinguir

`manage_actions_input()` no mira **nada** del entorno: la carga sube igual estés
delante de un botón picable o en mitad de un campo. La detección de objetos
interactuables **todavía no existe** (ver [11-alcance-y-estado.md](11-alcance-y-estado.md)),
así que ahora mismo el juego no tiene forma de saber si estás picando *algo* o
picando al aire.

### Los ejes que hay para separarlos

Sin elegir ninguno — la decisión es de diseño:

1. **Umbral y ventana**: hoy 3 toques / 0,5 s. Se puede pedir más toques, o una
   ventana más corta, o una cadencia sostenida en vez de un contador con decaída.
2. **Contexto**: cuando exista la detección de interactuables, el juego podrá
   saber si hay algo picable cerca. Es el único eje que distingue *intención*.
3. **Botón aparte**: `b_button` está libre. Rompe el "un botón, tres
   significados", que es parte de la gracia del diseño.

[ABIERTO] Cuál de los tres, o qué combinación.

## Lo que falta repartir

- **Visión especial** — candidata a `b_button`, el único libre. [ABIERTO] ¿toggle
  o mantener?
- **Coger / soltar objetos** — de diseño va en el mismo botón de picar (es el
  pico), y encaja: llevar objeto ⇒ picar pasa a ser soltar.
- Poner un huevo tarda 3 s con la gallina inmóvil. Con el perro corriendo es una
  decisión cara — bien, si es intencionado.
- [ABIERTO] Mando: nada mapeado todavía. Los nombres `a_button`/`b_button`
  sugieren que se quiere.
