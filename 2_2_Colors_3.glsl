#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution.xy;
    float y = st.y;

    float h = 1.0 / 6.0;

    //每条带由两个 step 相减得到（左闭右开）
    float band0 = 1.0 - step(h, y);                  // 0 <= y < 1/6
    float band1 = step(h, y) - step(2.0*h, y);      // 1/6 <= y < 2/6
    float band2 = step(2.0*h, y) - step(3.0*h, y);  // ...
    float band3 = step(3.0*h, y) - step(4.0*h, y);
    float band4 = step(4.0*h, y) - step(5.0*h, y);
    float band5 = step(5.0*h, y);                   // y >= 5/6

    vec3 red    = vec3(0.86, 0.08, 0.24);
    vec3 orange = vec3(1.00, 0.55, 0.00);
    vec3 yellow = vec3(1.00, 0.90, 0.00);
    vec3 green  = vec3(0.12, 0.70, 0.17);
    vec3 blue   = vec3(0.00, 0.45, 0.73);
    vec3 violet = vec3(0.50, 0.12, 0.50);

    vec3 color = vec3(0.0);
    color += band0 * red;
    color += band1 * orange;
    color += band2 * yellow;
    color += band3 * green;
    color += band4 * blue;
    color += band5 * violet;

    gl_FragColor = vec4(color, 1.0);
}
