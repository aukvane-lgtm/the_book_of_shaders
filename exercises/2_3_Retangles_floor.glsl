#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main(){
    vec2 st = gl_FragCoord.xy/u_resolution.xy;

    vec2 grid = floor(st * 10.0);   // 把画面切成10x10的格子

    // 用mod判断格子编号的奇偶，奇偶交替染色，形成棋盘格
    float pattern = mod(grid.x + grid.y, 2.0);

    vec3 color = vec3(pattern);
    gl_FragColor = vec4(color, 1.0);
}