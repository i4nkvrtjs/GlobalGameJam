shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float strength : hint_range(0.0, 0.05) = 0.0;
uniform float time_speed = 2.0;

void fragment() {
	vec2 uv = SCREEN_UV;

	float t = TIME * time_speed;
	float wave = sin(uv.y * 40.0 + t) * strength;

	uv.x += wave;
	uv.y += sin(uv.x * 30.0 + t) * strength * 0.5;

	COLOR = texture(SCREEN_TEXTURE, uv);
}
