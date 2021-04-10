Shader "Holistic/SimpleOutline" 
{
	Properties 
	{
		_Color ("Outline Color", Color) = (1,1,1,1)
		_Width("Outline Width", Range(0.01, 0.1)) = 0.05
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
	}

	SubShader
	{
		Tags{"Queue" = "Transparent"}

		ZWrite Off

		CGPROGRAM
		#pragma surface surf Lambert vertex:vert

		float _Width;

		void vert(inout appdata_full v)
		{
			v.vertex.xyz += v.normal * _Width;
		}
		
		struct Input 
		{
			float2 uv_MainTex;
		};

		fixed4 _Color;

		void surf (Input IN, inout SurfaceOutput o)
		{
			o.Emission = _Color;
		}
		ENDCG

		ZWrite On

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
	}
	FallBack "Diffuse"
}
