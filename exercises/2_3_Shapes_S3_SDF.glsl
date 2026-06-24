#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;

float rectOutline(vec2 st, vec2 size, float thickness) {
    // 把坐标系原点移到画面中心，方便对称地判断上下左右四条边
    vec2 d = abs(st - vec2(0.5)) - size;

    // d.x, d.y 分别是"横向、纵向距离矩形边界还有多远"
    // 取较大的那个，相当于"看离矩形最近的那条边有多远"
    float outer = max(d.x, d.y);

    // outer < 0.0 说明在矩形内部
    // outer > -thickness 说明没有深入太多，还在边框宽度范围内
    return (outer < 0.0 && outer > -thickness) ? 1.0 : 0.0;
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution.xy;

    float outline = rectOutline(st, vec2(0.3), 0.02);

    vec3 color = vec3(outline);
    gl_FragColor = vec4(color, 1.0);
}