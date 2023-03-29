
# Jaws
 
 #### Dylan Mills 100750193 |  Individual Assignment 2

 ## Forward and Deferred Rendering
![Rendering](https://raw.githubusercontent.com/DylanMills/Jaws/main/Images/RenderingDiagram.png)

## Additions


* Replaced Skybox
* Added movement
* Created scene
* Optimized meshes to reduce file size
* Reworked all materials, and shaders to match the project requirements
* Completely revamped wave shader
* Square shaped wave is possible via the following snippet(read the comments!)
```        void vert(inout appdata_full i) {
            //Using the time and vertex x coordinate to generate a sine wave
            float displacement = sin((i.vertex.x + _Time.y * _WaveSpeed) * _WaveFrequency); 
       
            //Force the wave to be either high or low, to make the wave square
            if (displacement > 0) {
                displacement = 1;
            }
            else if (displacement < 0) {
                displacement = -1;
            }
            else if (displacement == 0) {
                displacement = 0;
            }
            i.vertex = float4(i.vertex.x, i.vertex.y + displacement *_WaveAmplitude, i.vertex.z, i.vertex.w);
        }

```
        
* Bloom
-  Adjusted parameters
* Outlining
-  Adjusted parameter margins
-  Added better color controls
-  Added functional color tinting
-  Various optimizations for improved performance
* Hologram
- Making use of Rim Shading to create phantom Sharks
```         //get the dot product between the view direction and the surface normal, to create a value betwen 0 and 1
            half rim = 1.0- saturate(dot(normalize(IN.viewDir), o.Normal));
            // set emission to be the user-specified color, multiplied by the value we generated above, and exponentially change the value to further emphasize the rim shading 
            o.Emission = _RimColor.rgb * pow(rim, _RimPower) * 10;
            o.Alpha = pow(rim, _RimPower);
            
```
![Rendering](https://raw.githubusercontent.com/DylanMills/Jaws/main/Images/RimDiagram.png)

## Snippets
### Downsample Script
* This script downsamples using mipmapping
* It creates a new render texture at the destination parameter
* This is useful for optimizing graphics operations.
* Mipmapping allows for the renderer to use less detailed textures when the texel / pixel size diffent is high.
```
void OnRenderImage(RenderTexture source, RenderTexture destination){ 
 
        int width = source.width / integerRange;
        int height = source.height / integerRange;
        RenderTextureFormat format = source.format;
        RenderTexture[] textures = new RenderTexture[16]; 
 
        RenderTexture currentDestination = textures[0] = RenderTexture.GetTemporary(width, height, 0, format); 
 
        Graphics.Blit(source, currentDestination); 
        RenderTexture currentSource = currentDestination; 
        Graphics.Blit(currentSource, destination);
        RenderTexture.ReleaseTemporary(currentSource);

       

        for ( int i = 1;; i < iterations; i++) {
            width /= 2;
            height /= 2; 
            currentDestination = textures[i] = RenderTexture.GetTemporary(width, height, 0, format); 

            if (height < 2) {
                break; 
            } 

            currentDestination = RenderTexture.GetTemporary(width, height, 0, format); 
            Graphics.Blit(currentSource, currentDestination); 
            RenderTexture.ReleaseTemporary(currentSource);
            currentSource = currentDestination; 
        } 
 
        for (; i < iterations; i++) {
        Graphics.Blit(currentSource, currentDestination); 
        RenderTexture.ReleaseTemporary(currentSource);
        currentSource = currentDestination; 
 
        } 
 
        for (i -= 2; i >= 0; i--) {
        currentDestination = textures[i];
        textures[i] = null; 
        Graphics.Blit(currentSource, currentDestination); 
        RenderTexture.ReleaseTemporary(currentSource);
        currentSource = currentDestination; 
        } 
 
        Graphics.Blit(currentSource, destination);     } 
```
### Colored Shadow:
* This is a surface shader which uses a lambert lighting with a toon ramp
* It takes ShadowColor as a parameter which is used to color the dark areas of the surface
* This great for games with a simple art-style that wants to have a unique, stylized shadow color. 

```
Shader "ColoredShadow" 
{ 
    Properties{ 
     _Color("Main Color", Color) = (1,1,1,1) 
     _MainTex("Base (RGB)", 2D) = "white" {} 
    _ShadowColor("Shadow Color", Color) = (1,1,1,1) 
    } 
        SubShader{ 
 
            Tags { "RenderType" = "Opaque" } 
            LOD 200 
 
        CGPROGRAM 
        #pragma surface surf CSLambert 
 
        sampler2D _MainTex;         
        fixed4 _Color;         
        fixed4 _ShadowColor; 
 
        struct Input { 
            float2 uv_MainTex; 
        }; 
 
        half4 LightingCSLambert(SurfaceOutput s, half3 lightDir, half atten) { 
 
            fixed diff = max(0, dot(s.Normal, lightDir)); 
 
            half4 c; 
            c.rgb = s.Albedo * _LightColor0.rgb * (diff * atten * 0.5); 
 
            //shadow color 
            c.rgb += _ShadowColor.xyz * (1.0 - atten); 
            c.a = s.Alpha;
            return c; 
        } 
 
        void surf(Input IN, inout SurfaceOutput o) {
            half4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color; 
            o.Albedo = c.rgb; 
            o.Alpha = c.a; 
        } 
        ENDCG 
    } 
 
        Fallback "Diffuse" } 

  ```
## Download

You can [download](https://github.com/DylanMills/Jaws/releases/tag/release) the build here.


## Credits

This software uses the following external assets:

- [Skybox](https://assetstore.unity.com/packages/2d/textures-materials/sky/skybox-series-free-103633)
- [Shark](https://www.cgtrader.com/items/24982/download-page)
- [Ship](https://www.cgtrader.com/items/2712314/download-page)