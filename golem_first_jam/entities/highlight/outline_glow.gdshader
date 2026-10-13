shader_type canvas_item;

// 1px outline around the opaque pixels of a sprite, plus an optional pulsing glow.
// The quad grows by the outline width so the outline fits even when the art
// touches the texture border. Works with region (atlas) sprites if region_uv is set.

uniform vec4 outline_color : source_color = vec4(1.0, 0.95, 0.7, 1.0);
// In texture pixels
uniform float outline_width = 1.0;
// How much the sprite whitens at the top of the pulse (0 = no glow)
uniform float glow_amount : hint_range(0.0, 1.0) = 0.0;
// Pulses per second
uniform float glow_speed = 1.5;
// Region of the texture the sprite shows, in UV (x, y, width, height)
uniform vec4 region_uv = vec4(0.0, 0.0, 1.0, 1.0);

varying vec4 v_modulate;

void vertex() {
	v_modulate = COLOR;
	vec2 corner = sign(UV - (region_uv.xy + region_uv.zw * 0.5));
	VERTEX += corner * outline_width;
	UV += corner * outline_width * TEXTURE_PIXEL_SIZE;
}

bool in_region(vec2 uv) {
	return all(greaterThanEqual(uv, region_uv.xy)) && all(lessThanEqual(uv, region_uv.xy + region_uv.zw));
}

float alpha_at(sampler2D tex, vec2 uv) {
	return in_region(uv) ? texture(tex, uv).a : 0.0;
}

void fragment() {
	vec4 base = in_region(UV) ? texture(TEXTURE, UV) : vec4(0.0);
	vec2 px = TEXTURE_PIXEL_SIZE * outline_width;
	float neighbours = max(max(alpha_at(TEXTURE, UV + vec2(px.x, 0.0)), alpha_at(TEXTURE, UV - vec2(px.x, 0.0))),
			max(alpha_at(TEXTURE, UV + vec2(0.0, px.y)), alpha_at(TEXTURE, UV - vec2(0.0, px.y))));

	float pulse = (sin(TIME * glow_speed * 6.2831) * 0.5 + 0.5) * glow_amount;
	vec3 glowing = mix(base.rgb, vec3(1.0), pulse);

	if (base.a > 0.5) {
		COLOR = vec4(glowing, base.a) * v_modulate;
	} else if (neighbours > 0.5) {
		COLOR = vec4(outline_color.rgb, outline_color.a * v_modulate.a);
	} else {
		COLOR = vec4(0.0);
	}
}
