#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec3 color=vec3(0.0);

float rect(vec2 st, vec2 bottomLeft, vec2 topRight) {
    vec2 bl = step(bottomLeft, st);
    vec2 tr = step(topRight, 1.0 - st);
    return bl.x * bl.y * tr.x * tr.y;
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution.xy;

    float outerRect = rect(st, vec2(0.1), vec2(0.1));   // 大矩形（留白小）
    float innerRect = rect(st, vec2(0.12), vec2(0.12)); // 小矩形（留白大，所以矩形本身更小）
    
    float outline = outerRect - innerRect;   // 大减小，剩下一个细边框

    vec3 color = vec3(outline);
    gl_FragColor = vec4(color, 1.0);
}