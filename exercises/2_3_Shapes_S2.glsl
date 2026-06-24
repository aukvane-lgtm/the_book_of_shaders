#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec3 color=vec3(0.0);

float rectOutline(vec2 st, vec2 size, float thickness) {
    vec2 bl = step(size, st);              // 距离左/下边界的判断
    vec2 tr = step(size, 1.0 - st);        // 距离右/上边界的判断
    float outer = bl.x * bl.y * tr.x * tr.y;  // 大矩形（外边界）

    vec2 bl2 = step(size + thickness, st);
    vec2 tr2 = step(size + thickness, 1.0 - st);
    float inner = bl2.x * bl2.y * tr2.x * tr2.y;  // 小矩形（内边界）
    return outer - inner;
}
void main() {
    vec2 st = gl_FragCoord.xy / u_resolution.xy;
    vec3 color = vec3(rectOutline(st, vec2(0.1), 0.02)); // 绘制一个矩形边框，边框厚度为0.02
    gl_FragColor = vec4(color, 1.0);
}