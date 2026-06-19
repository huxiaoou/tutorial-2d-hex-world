shader_type canvas_item;

uniform vec2 tiling_offset = vec2(0.25, 0);
uniform float radius: hint_range(0.0, 1.0, 0.05) = 0.4;
uniform float tiling_scale: hint_range(0.2, 2.0, 0.02) = 0.6;

const vec2 center = vec2(0.5, 0.5);

void fragment() {
	COLOR = texture(TEXTURE, fract((UV + tiling_offset) * tiling_scale));
	float aspect_ratio = TEXTURE_PIXEL_SIZE.y / TEXTURE_PIXEL_SIZE.x;
	float d = distance(UV / vec2(1.0, aspect_ratio), center / vec2(1.0, aspect_ratio));
	COLOR.a = step(d, radius);
}