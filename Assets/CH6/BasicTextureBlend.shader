Shader "Holistic/BasicTextureBlend"
{
	Properties
	{
		_MainTex("Main Texture", 2D) = "white"{}
		_DecalTex("Decal Texture", 2D) = "white"{}

		[Toggle]
		_ShowDecal("Show Decal?", Float) = 0
	}

		SubShader
	{
		CGPROGRAM

		#pragma surface surf Lambert

		sampler2D _MainTex;
		sampler2D _DecalTex;
		float _ShowDecal;

		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
			float4 a = tex2D(_MainTex, IN.uv_MainTex);
			float4 d = tex2D(_DecalTex, IN.uv_MainTex) * _ShowDecal;
			o.Albedo.rgb = d.rgb > 0.9 ? d.rgb : a.rgb;
		}

		ENDCG
	}

	Fallback "Diffuse"
}