shader_type canvas_item;

uniform float height = 0.3;
uniform float scan_speed = 1.0;
uniform bool focused = false;

void fragment() {
    if (focused) {
        float center = fract(TIME * scan_speed);
        float d = smoothstep(0, height, abs(UV.y - center));
        COLOR.rgb = mix(COLOR.rgb, vec3(1), 1.0 - d);
    }
}