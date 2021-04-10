Shader "Holistic/PropertiesChallenge3"
{
	Properties
	{
		_myTex ("My Texture", 2D) = "White" {}
	}

	SubShader
	{
		CGPROGRAM

			#pragma surface surf Lambert
			
			struct Input
			{
				float2 uv_myTex;
			};

			sampler2D _myTex;
			
			void surf(Input IN, inout SurfaceOutput o)
			{
				float4 green = float4(0, 1, 0, 1);
				o.Albedo = tex2D(_myTex, IN.uv_myTex) * green;
			}

		ENDCG
	}

	FallBack "Diffuse"
}