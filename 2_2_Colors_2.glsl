#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

//basic gradient (1)
vec3 colorA = vec3(0.000,0.610,0.912);
vec3 colorB = vec3(1.000,0.971,0.012);

//plot the line(1)
float plot (vec2 st, float pct){
  return  smoothstep( pct-0.01, pct, st.y)-
          smoothstep( pct, pct+0.01, st.y);
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec3 color = vec3(0.0);
    vec3 pct = vec3(st.x);

    //pct.r = smoothstep(0.0,1.0, st.x);
    //pct.g = sin(st.x*PI);
    //pct.b = pow(st.x,0.5);
    // 取消注释后会改变渐变，因为 mix(colorA,colorB,pct) 使用 pct 的每个分量
    // 作为对应颜色通道的插值系数，修改任意通道的百分比都会影响最终背景色

    //basic gradient (2)
    color = mix(colorA, colorB, pct);
    //pct(pct.r, pct.g, pct.b) 代表了每个颜色通道的插值系数，分别控制红、绿、蓝通道的渐变程度

    // Plot the line in each channel (2)
    color = mix(color,vec3(1.0,0.0,0.0),plot(st,pct.r));
    color = mix(color,vec3(0.0,1.0,0.0),plot(st,pct.g));
    color = mix(color,vec3(0.0,0.0,1.0),plot(st,pct.b));

    gl_FragColor = vec4(color,1.0);
}
