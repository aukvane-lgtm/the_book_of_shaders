//基于上一个范例的变体
//Q2：If you look closely at the color wheel used on color pickers (see the image below), they use a different spectrum according to RYB color space. For example, the opposite color of red should be green, but in our example it is cyan. Can you find a way to fix that in order to look exactly like the following image? [Hint: this is a great moment to use shaping functions.]

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

float ryb2rgbHue(float t) {
    // t 是 0~1 的 RYB 色相输入
    if (t < 1.0/6.0) {
        return mix(0.0, 1.0/12.0, t / (1.0/6.0));
    } else if (t < 2.0/6.0) {
        return mix(1.0/12.0, 1.0/6.0, (t - 1.0/6.0) / (1.0/6.0));
    } else if (t < 3.0/6.0) {
        return mix(1.0/6.0, 1.0/3.0, (t - 2.0/6.0) / (1.0/6.0));
    } else if (t < 4.0/6.0) {
        return mix(1.0/3.0, 2.0/3.0, (t - 3.0/6.0) / (1.0/6.0));
    } else if (t < 5.0/6.0) {
        return mix(2.0/3.0, 5.0/6.0, (t - 4.0/6.0) / (1.0/6.0));
    } else {
        return mix(5.0/6.0, 1.0, (t - 5.0/6.0) / (1.0/6.0));
    }
}

void main(){
    vec2 st = gl_FragCoord.xy/u_resolution;
    vec3 color = vec3(0.0);

    // Use polar coordinates instead of cartesian
    vec2 toCenter = vec2(0.5)-st;
    float angle = atan(toCenter.y,toCenter.x);
    float hue = (angle/TWO_PI) + 0.5;
    float fixedHue = ryb2rgbHue(hue);
    float radius = length(toCenter)*2.0;

    // Map the angle (-PI to PI) to the Hue (from 0 to 1)
    // and the Saturation to the radius
    color = hsb2rgb(vec3(fixedHue,radius,1.0));

    gl_FragColor = vec4(color,1.0);
}

