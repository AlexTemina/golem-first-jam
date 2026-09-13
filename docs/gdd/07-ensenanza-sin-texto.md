# 07 — Cómo enseña el juego sin decir nada

Restricción autoimpuesta: **nada de tutoriales, nada de texto**. Todo se aprende
mirando o probando. Los cuatro canales que existen hoy:

## 1. Prueba y error contextual

El jugador solo sabe que un botón mueve la cabeza. Cerca de cosas, esa cabeza
hace cosas distintas. Es el canal de entrada y el que enseña picar, coger y
soltar.

## 2. NPCs que ejecutan la mecánica delante de ti

El patrón más fuerte del juego: **alguien lo hace, tú imitas**.

| Maestro | Enseña | Dónde |
| --- | --- | --- |
| Dos cuervos jugando | El ritmo de la campana: uno la pica, el otro reacciona | Sala oscura |
| Gallinas ponedoras | Poner huevos manteniendo el botón | Gallinero de ponedoras |
| Una gallina sentada | Los claros: se sienta y se le ponen los ojos en blanco | Bosque, nada más cruzar la carretera |
| Una gallina que vuela | Volar: mueve la cabeza muy rápido y despega | [ABIERTO], antes del río |
| El claro-tutorial | La visión especial — es siempre su primera pista | El claro practicable de al lado |

Regla que el propio diseño ya aplica: **maestro + sitio para practicarlo a dos
pasos**. La gallina de los claros tiene un claro al lado; los cuervos tienen la
campana delante.

Y todos son de **un solo uso en toda la partida**: una vez te han enseñado, no
hay que volver a verlos nunca. Después son paisaje.

### La cabeza es el botón

La gallina que vuela resuelve el problema de golpe, y merece la pena entender por
qué, porque el truco se puede reutilizar: **el botón mueve la cabeza, así que la
cabeza del maestro es la representación visible de lo que tú tienes que hacer con
el dedo**. Ves una gallina moviendo la cabeza muy rápido y despegando, y ya sabes
que hay que dar toques rápidos. Sin texto ni icono de mando: el mapeo entre gesto
y animación es 1 a 1.

[ABIERTO — el problema difícil] **Cómo se muestra "mantén pulsado un botón"**.
Ver a una gallina poner un huevo enseña *que se puede*, pero no *cómo*: una
gallina parada poniendo un huevo no le dice al jugador qué hacer con las manos.
La pregunta directa, ahora que existe el truco de arriba: ¿vale el mismo
mecanismo —que se le vea la cabeza mantenida abajo un buen rato antes de poner el
huevo— o hace falta otra cosa?

## 3. Los claros

El canal explícito, y el único que puede hablar de cualquier mecánica. La vista
sube al cielo y aparecen mensajes.

[DECIDIDO] **Su primera pista es siempre la visión especial.** Eso convierte a
los claros en el arranque de la progresión, no solo en una red de seguridad:
sin el claro-tutorial no hay visión, y sin visión no hay cuervos, ni ritmo, ni
huevos.

[DECIDIDO] El claro-tutorial está **nada más cruzar la carretera**, abierto y
accesible, con su gallina sentada al lado. Los demás claros van medio cerrados.
Consecuencia: el maestro más importante del juego está detrás del tractor, así
que el tractor deja de ser un puzzle paralelo y pasa a ser el prólogo
obligatorio. Ver [05-progresion.md](05-progresion.md).

[ABIERTO] Qué son exactamente esos "mensajes": pictogramas, siluetas, una
animación. Sin texto, tienen que ser legibles y no ambiguos.
[DECIDIDO] Varios claros repartidos, cada uno con su tipo de pista, en vez de
una lista lineal en un solo sitio.

## 4. Feedback de estado

Cosas que no enseñan una mecánica pero evitan que el jugador se vuelva loco:
- El cuervo que **viene, da una vuelta y se va** cuando esa campana ya cumplió
  su función = "esto ya está hecho".
- La gallina que **se espanta y retrocede** ante los coches = "por aquí todavía
  no".
- La serpiente que **te pica y te echa atrás** = "necesitas algo".
- La cadena rota = "se acabó el tiempo", sin números.

Estos rechazos son buenos: dicen *no* sin decir *nunca*.
