
# Jaws
 
 Dylan Mills 100750193
 Individual Assignment 2


![Rendering](https://raw.githubusercontent.com/DylanMills/Jaws/main/Images/RenderingDiagram.png)

## Additions

* Reworked all materials, and shaders to match the project requirements
  -  Adjusted parameter margins
  -  Revamped Wave
  -  Optimized outline shader
  -  added functional color tinting
* Replaced Skybox
* Square shaped wave is created by 
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
-  
* Outlining
* Hologram
- Making use of Rim Shading to create phantom Sharks
```         //get the dot product between the view direction and the surface normal, to create a value betwen 0 and 1
            half rim = 1.0- saturate(dot(normalize(IN.viewDir), o.Normal));
            // set emission to be the user-specified color, multiplied by the value we generated above, and exponentially change the value to further emphasize the rim shading 
            o.Emission = _RimColor.rgb * pow(rim, _RimPower) * 10;
            o.Alpha = pow(rim, _RimPower);
            
```
![Rendering](https://raw.githubusercontent.com/DylanMills/Jaws/main/Images/RimDiagram.png)

## Download

You can [download](https://github.com/DylanMills/Jaws/releases/tag/beta) the build here.


## Credits

This software uses the following external assets:

- [Skybox](https://assetstore.unity.com/packages/2d/textures-materials/sky/skybox-series-free-103633)
- [Shark](https://www.cgtrader.com/items/24982/download-page)
- [Ship](https://www.cgtrader.com/items/2712314/download-page)