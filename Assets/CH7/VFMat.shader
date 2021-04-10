Shader "Holistic/VFMat"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white"{}
		_ScaleUVX("Scale X", Range(1,10)) = 1
		_ScaleUVY("Scale Y", Range(1,10)) = 1
	}

	SubShader
	{
		Tags{ "Queue" = "Transparent" }
		GrabPass{}
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			sampler2D _MainTex;
			sampler2D _GrabTexture;
			float4 _MainTex_ST;
			float _ScaleUVX;
			float _ScaleUVY;

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{		
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.uv.x = sin(o.uv.x * _ScaleUVX);
				o.uv.y = sin(o.uv.y * _ScaleUVY);
				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				fixed4 c;
				c = tex2D(_GrabTexture, i.uv);
				return c;
			}
			ENDCG
		}
	}
}