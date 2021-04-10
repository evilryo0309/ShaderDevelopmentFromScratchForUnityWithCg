Shader "Holistic/VFDiffuse"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white"{}
	}

	SubShader
	{
		Pass
		{
			Tags{ "LightMode" = "ForwardBase"}

			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			#include "UnityLightingCommon.cginc"

			sampler2D _MainTex;
			
			struct appdata
			{
				float4 vertex : POSITION;
				float4 texcoord : TEXCOORD0;
				float3 normal : NORMAL;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
				fixed4 diff : COLOR0;
			};

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.texcoord;
				half3 worldNormal = UnityObjectToWorldNormal(v.normal);
				half nl = max(0, dot(worldNormal, _WorldSpaceLightPos0.xyz));
				o.diff = nl * _LightColor0;
				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				fixed4 col;
				col = tex2D(_MainTex, i.uv);
				col *= i.diff;
				return col;
			}
			
			ENDCG
		}
	}
}