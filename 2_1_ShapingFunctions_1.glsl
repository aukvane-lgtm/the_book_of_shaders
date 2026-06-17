#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

// 函数定义
float plot(vec2 st) {    
    //        ↑ 这里的 vec2 st 是"形参声明"
    return 1.0-smoothstep(0.0, 0.02, abs(st.y - st.x));
    // 原书写法：return smoothstep(0.02, 0.0, abs(st.y-st.x))
        // smoothstep(edge0,edge1,x),一般要求edge0<edge1,严格来说用例并不是规范写法
        // abs(edge0-edge1)= 线段宽度
    // 输出smoothstep的插值，范围在0.0~1.0内
}

void main() {
	vec2 st = gl_FragCoord.xy/u_resolution;
    float y = st.x;
    vec3 color = vec3(y);

    // 函数调用
    float pct = plot(st);
	color = mix(color, vec3(1.000,0.149,0.624), pct);
    // 原书写法：color = (1.0-pct)*color+pct*vec3(0.0,1.0,0.0)
        // mix函数用法见下一章节

	gl_FragColor = vec4(color,1.0);
}