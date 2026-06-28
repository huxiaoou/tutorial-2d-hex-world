shader_type canvas_item;

uniform float pixel_size : hint_range(1.0, 64.0) = 4.0;
uniform float color_levels : hint_range(2.0, 32.0) = 16.0;

void fragment() {
    vec2 tex_size = 1.0 / TEXTURE_PIXEL_SIZE;

    // Convert UV to texture pixel coordinates.
    vec2 pixel_coord = UV * tex_size;

    // Snap coordinates to a larger grid.
    pixel_coord = floor(pixel_coord / pixel_size) * pixel_size;

    // Convert back to UV.
    vec2 snapped_uv = pixel_coord / tex_size;

    vec4 col = texture(TEXTURE, snapped_uv);

    // Optional palette reduction.
    col.rgb = floor(col.rgb * color_levels) / color_levels;

    COLOR = col;
}