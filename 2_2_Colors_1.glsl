#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

vec3 colorA = vec3(1.0, 0.6353, 0.8588);
vec3 colorB = vec3(1.0, 0.9529, 0.5137);

void main() {
    vec3 color = vec3(0.0);
    //初始化颜色color=(0.0,0.0,0.0)
    
    float pct= abs(sin(u_time));
    color=mix(colorA,colorB,pct);

    gl_FragColor = vec4(color,1.0);
}

// uniform→定义颜色→**初始化**→渐变百分比→混合→输出