Shader "Holistic/UVScroll"
{
	Properties 
	{
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_ScrollX ("ScrollX", Range(-5,5)) = 0
		_ScrollY ("ScrollY", Range(-5,5)) = 0
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

		float _ScrollX;
		float _ScrollY;

		void surf (Input IN, inout SurfaceOutput o) 
		{
			_ScrollX *= _Time;
			_ScrollY *= _Time;
			float2 newUV = IN.uv_MainTex + float2(_ScrollX, _ScrollY);
			fixed4 c = tex2D (_MainTex, newUV);
			o.Albedo = c.rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
