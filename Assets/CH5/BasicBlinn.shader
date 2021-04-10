Shader "Holistic/BasicBlinn" 
{
	Properties 
	{
		_Color ("Color", Color) = (1,1,1,1)
		_SpecColor("Color", Color) = (1,1,1,1)
		_Spec("Spec", Range(0,1)) = 0.5
		_Gloss ("Gloss", Range(0,1)) = 0.5
	}
	SubShader 
	{
		Tags
		{
			"RenderType"="Opaque"
		}

		CGPROGRAM
		#pragma surface surf BlinnPhong

		struct Input 
		{
			float2 uv_MainTex;
		};

		float4 _Color;
		half _Spec;
		half _Gloss;

		void surf (Input IN, inout SurfaceOutput o) 
		{
			o.Albedo = _Color;
			o.Specular = _Spec;
			o.Gloss = _Gloss;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
