Shader "Holistic/AdOutline"
{
	Properties
	{
		_Color("Outline Color", Color) = (1,1,1,1)
		_Width("Outline Width", Range(0.01, 0.1)) = 0.05
		_MainTex("Albedo (RGB)", 2D) = "white" {}
	}

	SubShader
	{
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;

		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = c;
		}
		ENDCG

		Pass
		{
			Cull Front

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
				fixed4 color : COLOR;
			};

			float4 _Color;
			float _Width;

			v2f vert(appdata v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				float3 norm = normalize(mul((float3x3)UNITY_MATRIX_IT_MV, v.normal));
				float2 offset = TransformViewToProjection(norm.xy);

				o.pos.xy += offset * o.pos.z * _Width;
				o.color = _Color;
				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				return i.color;
			}

			ENDCG
		}
	}
	FallBack "Diffuse"
}
