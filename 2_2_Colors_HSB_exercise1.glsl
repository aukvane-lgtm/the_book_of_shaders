//基于上一个范例的变体
#ifdef GL_ES
precision mediump float;
#endif

#define TWO_PI 6.28318530718

uniform vec2 u_resolution;
uniform float u_time;

//  Function from Iñigo Quiles
//  https://www.shadertoy.com/view/MsS3Wc
vec3 hsb2rgb( in vec3 c ){
    vec3 rgb = clamp(abs(mod(c.x*6.0+vec3(0.0,4.0,2.0),
                             6.0)-3.0)-1.0,
                     0.0,
                     1.0 );
    rgb = rgb*rgb*(3.0-2.0*rgb);
    return c.z * mix( vec3(1.0), rgb, c.y);
}

void main(){
    vec2 st = gl_FragCoord.xy/u_resolution;
    vec3 color = vec3(0.0);

    // Use polar coordinates instead of cartesian
    vec2 toCenter = vec2(0.5)-st;
    float angle = atan(toCenter.y,toCenter.x);
    float hue = (angle/TWO_PI) + 0.5;
    //用hue代替了原先的angle/TWO_PI+0.5，方便后续对hue进行调整
    hue = pow(hue, 2.0);
    float radius = length(toCenter)*2.0;
    radius = sqrt(radius);
    //radius = pow(radius, 3.0);
    //pow先慢后快，中间饱和度低四周饱和度高，sqrt先快后慢，中间饱和度高四周饱和度低

    // Map the angle (-PI to PI) to the Hue (from 0 to 1)
    // and the Saturation to the radius
    color = hsb2rgb(vec3(hue+u_time*0.5,radius,1.0));

    gl_FragColor = vec4(color,1.0);
}
