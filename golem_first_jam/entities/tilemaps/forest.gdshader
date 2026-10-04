shader_type canvas_item;

// Wind sway for trees, as TileMapLayer tiles or Sprite2D nodes.
// Each tile shears around its base (top vertices move, bottom stays put),
// with a per-tile random phase/strength so the forest doesn't move in sync,
// plus slow gusts that travel across the map.

// Max horizontal displacement of the treetop, in pixels.
uniform float sway_amount : hint_range(0.0, 16.0) = 3.0;
// Base oscillation speed.
uniform float sway_speed : hint_range(0.0, 5.0) = 1.1;
// How much stronger gusts get on top of the base sway (0 = no gusts).
uniform float gust_strength : hint_range(0.0, 2.0) = 0.8;
// Gust wave length across the map, in pixels (bigger = wider gust fronts).
uniform float gust_scale = 600.0;
// Wind direction: 1 = to the right, -1 = to the left.
uniform float wind_direction : hint_range(-1.0, 1.0) = 1.0;
// Tiny per-pixel wobble in the foliage, in pixels (0 to disable).
uniform float leaf_flutter : hint_range(0.0, 3.0) = 0.5;

varying float v_top;     // 1 at the top of the tile, 0 at the base
varying float v_seed;    // per-tile random value
varying vec4 v_modulate; // vertex color (modulate), before texture

float hash(vec2 p) {
	p = mod(p, 1024.0); // keep sin() precise with big world coords
	return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}

void vertex() {
	v_modulate = COLOR;

	// Constant for all 4 vertices of a tile/sprite -> stable per-tree seed.
	// World space so every Sprite2D instance (same local coords) differs.
	vec2 world = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
	vec2 tile_id = floor(world - UV / TEXTURE_PIXEL_SIZE + 0.5);
	float seed = hash(tile_id);
	v_seed = seed;

	// Quads only have 4 verts: top ones get full sway, bottom ones none.
	// Assumes one tree per texture height (true for BoundaryForest_1).
	float top = UV.y < 0.5 ? 1.0 : 0.0;
	v_top = top;

	float t = TIME * sway_speed;
	float phase = seed * 6.2831;
	float speed_jitter = mix(0.8, 1.25, fract(seed * 7.13));

	// Base sway: two detuned sines so it never looks like a metronome.
	float sway = sin(t * speed_jitter + phase) * 0.7
			+ sin(t * 1.73 * speed_jitter + phase * 2.1) * 0.3;

	// Gusts: slow wave rolling across the map in the wind direction.
	float gust = sin(tile_id.x / gust_scale * 6.2831 - TIME * 0.6 * wind_direction);
	gust = smoothstep(0.2, 1.0, gust) * gust_strength;

	// Lean with the wind during gusts, oscillate around that.
	float strength = mix(0.75, 1.15, fract(seed * 3.71));
	float offset = (sway + gust * wind_direction) * sway_amount * strength;

	// Align the whole tree to the screen pixel grid. Trees can sit on half
	// pixels (128px texture centered in a 117px cell, smoothed camera), which
	// with linear filtering blurs the whole sprite. Snap one shared reference
	// point (texture origin, computed before the sway so it's identical for
	// all 4 vertices) and move every vertex by the same amount. The 0.51
	// bias keeps exact .5 positions from rounding inconsistently.
	mat4 to_canvas = CANVAS_MATRIX * MODEL_MATRIX;
	vec2 ref = (to_canvas * vec4(VERTEX - UV / TEXTURE_PIXEL_SIZE, 0.0, 1.0)).xy;
	vec2 snap_delta = floor(ref + 0.51) - ref;

	VERTEX.x += offset * top;

	vec2 v = (to_canvas * vec4(VERTEX, 0.0, 1.0)).xy + snap_delta;
	VERTEX = (inverse(to_canvas) * vec4(v, 0.0, 1.0)).xy;
}

void fragment() {
	vec2 uv = UV;
	if (leaf_flutter > 0.0) {
		// Ripple stronger towards the top of the tree, none at the trunk.
		float w = v_top * v_top;
		float ripple = sin(UV.y / TEXTURE_PIXEL_SIZE.y * 0.15 + TIME * 2.3 + v_seed * 20.0);
		uv.x += ripple * leaf_flutter * TEXTURE_PIXEL_SIZE.x * w;
	}
	// COLOR here already includes the texture, so rebuild it from the
	// vertex color instead of multiplying the texture in twice.
	COLOR = texture(TEXTURE, uv) * v_modulate;
}
