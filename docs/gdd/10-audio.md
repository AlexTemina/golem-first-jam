# 10 — Música y sonido

> Tampoco está definido en diseño. Aquí va el estado del código y lo que el
> diseño **obliga** a que exista.

## Estado actual [CÓDIGO]

`managers/sound_manager/sound_manager.gd` tiene un enum `ChickenSound`:

| Sonido | ¿Tiene audio? |
| --- | --- |
| `WALK` | No |
| `PECK` | No |
| `LAY_EGG` | Sí — `pop1.wav`, `pop2.wav` |
| `FLY` | Sí — `fly1.wav`, `fly2.wav` |
| `CACKLE` | No |

Reproduce uno al azar de la lista y le aplica un **pitch aleatorio ±0.2**, que
es la forma barata y correcta de que no canse. Se dispara vía `SignalBus`
(`play_chicken_sound`, y `chicken_flies` conectado directamente a `FLY`).

Fuentes acreditadas en `CREDITS.md` (freesound.org, CC0 / CC-BY 4.0). Hay un
`Chickens.wav` descargado que todavía no se usa.

## El audio **es** una mecánica

Esto no es decoración: la campana rítmica es un puzzle de audio. El jugador
tiene que **escuchar un patrón, memorizarlo y reproducirlo**. Consecuencias
directas:

- La campana necesita un sonido limpio, corto y de ataque claro, para que el
  ritmo se lea sin ambigüedad.
- El patrón que pican los cuervos tiene que ser corto y repetirse en bucle
  mientras el jugador mira.
- [DECIDIDO] **El ritmo tiene apoyo visual.** El patrón se ve además de oírse:
  movimiento de la campana y efectos en cada golpe, de forma que quien juegue en
  silencio pueda seguirlo igual. Aplica a los dos lados de la mecánica: al cuervo
  que lo enseña y a la campana que tú picas.
- [ABIERTO] Tolerancia del ritmo: cuánto margen de error se acepta al picar.

## Por decidir

- [ABIERTO] Música: si la hay, qué estilo, si cambia por zona.
- [ABIERTO] Cómo suena la presión del tiempo (la cadena es hoy solo visual).
- [ABIERTO] Ambiente de granja vs. bosque vs. interiores.
- [ABIERTO] Sonidos que faltan por implementar: pasos, picotazo, cacareo, coches,
  serpiente, perro, cuervo, tractor.
