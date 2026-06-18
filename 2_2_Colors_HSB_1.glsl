#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

//  Function from Iñigo Quiles
//  https://www.shadertoy.com/view/MsS3Wc
vec3 hsb2rgb( in vec3 c ){
    //in表示只读输入，out-只读输入、in-只写输出、inout-既读又写
    //int newFunction(in vec4 aVec4,   // read-only
    //            out vec3 aVec3,    // write-only
    //            inout int aInt);   // read-write
    //c是定义的变量名，c.x是色相（hue），c.y是饱和度（saturation），c.z是亮度（brightness）
    vec3 rgb = clamp(abs(mod(c.x*6.0+vec3(0.0,4.0,2.0),
                             6.0)-3.0)-1.0,
                     0.0,
                     1.0 );
    // mod函数将色相乘以6后取模，得到一个在0到6之间的值。
    // 这个值加上(0,4,2)后，分别对应RGB三个通道的计算。abs和clamp函数确保结果在0到1之间。
    rgb = rgb*rgb*(3.0-2.0*rgb);
    return c.z * mix(vec3(1.0), rgb, c.y);
}

void main(){
    vec2 st = gl_FragCoord.xy/u_resolution;
    vec3 color = vec3(0.0);

    // We map x (0.0 - 1.0) to the hue (0.0 - 1.0)
    // And the y (0.0 - 1.0) to the brightness
    color = hsb2rgb(vec3(st.x,sin(u_time),st.y));

    gl_FragColor = vec4(color,1.0);
}
