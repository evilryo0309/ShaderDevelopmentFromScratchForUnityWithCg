Shader "Holistic/Extrude" 
{
	Properties 
	{
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Amount("Amount", Range(-1, 1)) = 0
	}

	SubShader 
	{
		Tags { "RenderType"="Opaque" }

		CGPROGRAM
		#pragma surface surf Lambert vertex:vert

		struct appdata
		{
			float4 vertex : POSITION;
			float3 normal : NORMAL;
			float4 texcoord : TEXCOORD0;
			float4 texcoord1 : TEXCOORD1;
			float4 texcoord2 : TEXCOORD2;
		};

		float _Amount;

		void vert(inout appdata v)
		{
			v.vertex.xyz += v.normal * _Amount;
		}

		sampler2D _MainTex;

		struct Input 
		{
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) 
		{
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
