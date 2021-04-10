Shader "Holistic/UVScrollWater"
{
	Properties 
	{
		_MainTex ("Water", 2D) = "white" {}
		_FoamTex ("Foam", 2D) = "white" {}
		_ScrollX ("ScrollX", Range(-5,5)) = 1
		_ScrollY ("ScrollY", Range(-5,5)) = 1
	}
	SubShader 
	{
		CGPROGRAM

		#pragma surface surf Lambert

		sampler2D _MainTex;
		sampler2D _FoamTex;

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
			fixed4 water = tex2D (_MainTex, IN.uv_MainTex + float2(_ScrollX, _ScrollY));
			fixed4 foam = tex2D(_FoamTex, IN.uv_MainTex + float2(_ScrollX, _ScrollY) / 2);
			o.Albedo = (water + foam) / 2.4;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
