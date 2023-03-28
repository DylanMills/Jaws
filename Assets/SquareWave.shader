Shader "Custom/SquareWave" {
    Properties {
        _Amplitude ("Amplitude", Range(0, 1)) = 0.5
        _Frequency ("Frequency", Range(0, 100)) = 1
        _Speed ("Speed", Range(0, 10)) = 1
    }

    SubShader {
        Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata {
                float4 vertex : POSITION;
            };

            struct v2f {
                float4 vertex : SV_POSITION;
            };

            float _Amplitude;
            float _Frequency;
            float _Speed;

            v2f vert (appdata v) {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target {
                float wave = sin((i.vertex.x + _Time.y * _Speed) * _Frequency * 2 * 3.14);
                if (wave > 0)
                    return fixed4(1, 1, 1, 1) * _Amplitude;
                else
                    return fixed4(0, 0, 0, 1);
            }
            ENDCG
        }
    }
}
