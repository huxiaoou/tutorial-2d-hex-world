shader_type canvas_item;

uniform vec2 tiling_offset = vec2(0.35, 0);
uniform float tiling_scale: hint_range(0.2, 1.0, 0.01) = 0.6;

const vec2 center = vec2(0.5, 0.5);
const float radius = 0.5;

void fragment() {
	const float aspect_ratio = TEXTURE_PIXEL_SIZE.y / TEXTURE_PIXEL_SIZE.x;
	COLOR = texture(TEXTURE, fract((UV + tiling_offset) * vec2(1, aspect_ratio) * tiling_scale));
	float d = distance(UV, center);
    COLOR.a *= step(d, radius);
}