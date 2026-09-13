# 09 — Estilo gráfico

> Este apartado **no está definido en diseño**. Lo que sigue es lo que el
> proyecto ya impone técnicamente, más los huecos por rellenar.

## Lo que ya está fijado por el proyecto [CÓDIGO]

| Parámetro | Valor | Dónde |
| --- | --- | --- |
| Resolución de render | **320 × 180** | `project.godot`, `display/window/size` |
| Escalado | `viewport` + `integer` | Pixel art puro, sin píxeles rotos |
| Snap de vértices 2D | Activado | `rendering/2d/snap` |
| Tamaño de tile | 32 px | `states/screen_props.gd` |
| Resolución lógica de referencia | 640 × 360 | `ScreenProps.WIDTH/HEIGHT` |
| Cámara | Addon **Phantom Camera** | `addons/phantom_camera` |
| Orden de dibujado | `z_index = position.y` | Clásico top-down por profundidad |
| Fuente | Nunito (Regular / Black) | Importada en el proyecto |

320 × 180 es **muy poca resolución**: unos 10 × 5,6 tiles en pantalla. Condiciona
todo lo demás — las lecturas tienen que ser de silueta, no de detalle.

## Animaciones existentes de la gallina [CÓDIGO]

`idle`, `move`, `peck`, `fly`, `lay_egg`. El volteo horizontal es por
`sprite.scale.x`. La altura de vuelo se simula con `sprite.offset.y`, el
personaje no cambia de plano de colisión.

## Por decidir

- [ABIERTO] **Paleta** y referencias visuales concretas.
- [ABIERTO] **Shader de la visión especial**: es el efecto estrella del juego.
  Tiene que resolver dos cosas a la vez — hacer legible lo oscuro y mostrar
  grados de temperatura — sin que la pantalla se vuelva ilegible a 320 × 180.
- [ABIERTO] **HUD de la cadena**: hoy 4 frames. Con runs de 1–2 minutos, 4
  estados son muy pocos para leer la urgencia; probablemente haga falta más
  granularidad o un apoyo extra.
- [ABIERTO] **Imagen de captura del perro** (pantalla de fin de run).
- [ABIERTO] **Pictogramas de los claros**: cómo se dibuja una pista sin texto.
- [ABIERTO] Paso de día/noche, iluminación de interiores, clima: nada decidido.

## Lo que ya existe en el repo

`test_32.png` y `test_tileset_32.png` son placeholders. Todo el arte definitivo
está por hacer.
