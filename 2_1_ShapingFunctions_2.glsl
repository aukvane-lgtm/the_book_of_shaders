// Author: Inigo Quiles
// Title: Expo

#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float plot(vec2 st, float pct){
  return  smoothstep( pct-0.02, pct, st.y) -
          smoothstep( pct, pct+0.02, st.y);
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution;

	float y = exp(st.x*3.0)/exp(3.0);
    //float y= pow(st.x,3.0) pow(x,a) 求x的a次幂
    //float y = log(st.x*9.0 + 1.0)/log(10.0) log(st.x)不行因为st.x∈[0.0,1.0]
    //float y = sqrt(st.x)
    //float y = sin(st.x * PI) ;

    vec3 color = vec3(y);

    float pct = plot(st,y);
    color = (1.0-pct)*color+pct*vec3(0.0,1.0,0.0);

    gl_FragColor = vec4(color,1.0);
}