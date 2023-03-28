Shader "Custom/NewWater"
{
    Properties
    {
        _MainTex ("Diffuse", 2D) = "white" {}
        _Tint("Colour Tint",Color)=(1,1,1,1)
        _Freq("Frequency",Range(0,1))=1
        _Speed("Speed",Range(0,50))=40
        _Amp("Amplitude",Range(0,1))=0.8
        
    }
    SubShader
    {
    CGPROGRAM
    #pragma surface surf Lambert vertex:vert

            struct Input{
            float2 uv_MainTex;
            float3 vertColor;
            };
            float4 _Tint;
            float _Freq;
            float _Speed;
            float _Amp;
           

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal:NORMAL;
                float4 texcoord:TEXCOORD0;
                float4 texcoord1:TEXCOORD1;
                float4 texcoord2:TEXCOORD2;
            };

void vert (inout appdata v, out Input o){
UNITY_INITIALIZE_OUTPUT(Input,o);
float t = _Time * _Speed;
 float wave = abs(sin((v.vertex.x + t) * _Freq * 3.14)*2);
//float waveHeight = (sin((v.vertex.x * (t + _Freq))))*_Amp;   
wave=round((wave)-1)*_Amp;
v.vertex.y+=wave;
v.normal=normalize(float3(1,1,1));
o.vertColor=wave+2;

}

            sampler2D _MainTex;


   void surf(Input IN, inout SurfaceOutput o){
   float4 c = tex2D(_MainTex,IN.uv_MainTex);
   o.Albedo=c*IN.vertColor.rgb *_Tint;
   
   }
         
         
            ENDCG
        }
    Fallback "Diffuse"
}