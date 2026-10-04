shader_type canvas_item;

// Animated water for full-water TileMapLayer tiles (pixel-art friendly).
// Rows of texels wobble left/right by whole pixels following a wave that
// travels across the world, plus optional current and sparse sparkles.
// Sampling wraps inside the tile's own atlas cell, so the tile must be
// seamless with itself (plain water fill, not shore/edge tiles).

// Atlas cell size in texels.
uniform float tile_px = 32.0;
// Max horizontal wobble, in whole pixels.
uniform float wobble_amount : hint_range(0.0, 4.0) = 1.0;
// Rows per wave (bigger = taller wave bands).
uniform float wobble_length : hint_range(2.0, 64.0) = 14.0;
// How fast the wave moves.
uniform float wobble_speed : hint_range(0.0, 10.0) = 2.0;
// Current, in pixels per second (x, y). 0 = still water.
uniform vec2 flow = vec2(0.0, 0.0);
// Sparkle density (0 = off) and how often they change per second.
uniform float sparkle_density : hint_range(0.0, 0.05) = 0.0015;
uniform float sparkle_rate : hint_range(0.5, 20.0) = 3.0;
uniform vec4 sparkle_color : source_color = vec4(0.8, 0.96, 1.0, 1.0);

varying vec2 v_world;    // world position, for wave/sparkles across tiles
varying vec4 v_modulate; // vertex color (modulate), before texture

float hash(vec2 p) {
	p = mod(p, 1024.0); // keep sin() precise with big world coords
	return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}

void vertex() {
	v_modulate = COLOR;
	v_world = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
}

void fragment() {
	vec2 texel = floor(UV / TEXTURE_PIXEL_SIZE);
	vec2 cell = floor(texel / tile_px) * tile_px;
	vec2 world_texel = floor(v_world);

	// Whole-pixel row offsets: two detuned waves so it doesn't look regular.
	float row = world_texel.y;
	float wave = sin(row / wobble_length * 6.2831 + TIME * wobble_speed) * 0.7
			+ sin(row / (wobble_length * 0.43) * 6.2831 - TIME * wobble_speed * 0.6
				+ world_texel.x * 0.05) * 0.3;
	vec2 offset = vec2(round(wave * wobble_amount), 0.0);
	offset -= floor(flow * TIME);

	// Wrap inside this tile's atlas cell.
	vec2 local = mod(texel - cell + offset, tile_px);
	vec2 uv = (cell + local + 0.5) * TEXTURE_PIXEL_SIZE;

	// COLOR here already includes the texture, so rebuild it from the
	// vertex color instead of multiplying the texture in twice.
	vec4 col = texture(TEXTURE, uv);

	// Sparse sparkles, stable for a short moment then moving elsewhere.
	float step_t = floor(TIME * sparkle_rate);
	if (hash(world_texel + vec2(step_t * 13.7, step_t * 7.3)) < sparkle_density) {
		col.rgb = mix(col.rgb, sparkle_color.rgb, sparkle_color.a);
	}

	COLOR = col * v_modulate;
}
