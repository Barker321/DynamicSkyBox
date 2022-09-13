Shader "Unlit/SkyBox"
{
    Properties
    {
        [Header(Sun Setting)]
        _SunDirection("Sun Direction", vector) = (0, 0, 1, 1)
        _SunRadius("Sun Radius",  Range(0, 2)) = 0.1
        _SunColor("Sun Color", Color) = (1, 1, 1, 1)
        _SunInnerBoundary("Sun inner boundary", float) = 0.5
        _SunOuterBoundary("Sun outer boundary", float) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float3 uv : TEXCOORD0;
            };

            struct v2f
            {
                float3 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float _SunInnerBoundary, _SunOuterBoundary;
            float _SunRadius;
            float4 _SunColor;
            float3 _SunDirection;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float sunDistance = distance(i.uv.xyz, -_SunDirection);
                float sunArea = 1 - sunDistance / _SunRadius;
                sunArea = smoothstep(_SunInnerBoundary, _SunOuterBoundary, sunArea);
                return fixed4(sunArea, 0, 0, 1);
            }
            ENDCG
        }
    }
}
