//
//  Metal.metal
//  MetaWarpPlayground
//
//  Created by Minsang Choi on 11/27/24.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI.h>
using namespace metal;

[[ stitchable ]] half4 particlesin(float2 pos, SwiftUI::Layer l, float2 size, float2 drag, float factor, float dynamic) {

    float2 newsize = size * 0.3;
    float2 uv = pos / newsize;
    float2 ud = drag / newsize;
    
    float distance = length(uv - ud);

    float warpfactor = sin(distance * 3.14 + dynamic) * factor;
    uv -= normalize(uv - ud) * 0.01 * pow(warpfactor,2);

    half4 color = half4(l.sample(uv*newsize).r,l.sample(uv*newsize).g,l.sample(uv*newsize).b,1.0);
    
    return color;
}



[[ stitchable ]] half4 particlecos(float2 pos, SwiftUI::Layer l, float2 size, float2 drag, float factor, float dynamic) {
  
    float2 newsize = size * 0.5;
    float2 uv = pos / newsize;
    float2 ud = drag / newsize;
    
    float distance = length(uv - ud);

    float warpfactor = cos(distance * 300 + dynamic) * factor;
    uv -= normalize(uv - ud) * 0.01 * pow(warpfactor,2);

    half4 color = half4(l.sample(uv*newsize+factor*2.0).r,l.sample(uv*newsize-factor*0.5).g,l.sample(uv*newsize+factor*1.0).b,1.0);
    
    return color;
}



[[ stitchable ]] half4 particletan(float2 pos, SwiftUI::Layer l, float2 size, float2 drag, float factor, float dynamic) {

    float2 uv = pos / size;
    float2 ud = drag / size;
    
    float distance = length(uv - ud);

    float warpfactor = tan(distance * 3.14 + dynamic) * factor;
    uv -= normalize(uv - ud) * 0.01 * pow(warpfactor,2);

    half4 color = half4(l.sample(uv*size+factor*2.0).r,l.sample(uv*size-factor*0.5).g,l.sample(uv*size+factor*1.0).b,1.0);
    
    return color;
}

[[ stitchable ]] half4 particlerand(float2 pos, SwiftUI::Layer l, float2 size, float2 drag, float factor, float dynamic, float numbers) {

    float2 uv = pos / size;
    float2 ud = drag / size;
    
    float distance = length(uv - ud);

    float warpfactor = exp(distance * 0.03 + dynamic) * factor;
    uv += normalize(uv - ud) * 0.01 * pow(warpfactor,2);
    
    half3 colors = 0;
    
    int iterations = int(numbers);
    
    for (int i = 0; i < iterations; ++i) {
        float blendFactor = exp(warpfactor / (i * 3));
        colors += half3(
            l.sample(uv * size + blendFactor * abs(8-iterations) * 0.1).r,
            l.sample(uv * size - blendFactor * abs(5-iterations) * 0.1).g,
            l.sample(uv * size - blendFactor * abs(4-iterations) * 0.1).b
        );
    }
    return half4(colors,1);
}
