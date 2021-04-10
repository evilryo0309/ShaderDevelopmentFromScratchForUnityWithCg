Shader "Holistic/PropertiesChallenge2"
{
	Properties
	{
		_myTex("MyTexture", 2D) = "White"{}
	}

	SubShader
	{
		CGPROGRAM
			#pragma surface surf Lambert
			
			struct Input
			{
				fixed2 uv_myTex;
			};

			sampler2D _myTex;

			void surf(Input IN, inout SurfaceOutput o)
			{
				o.Albedo.rb = tex2D(_myTex, IN.uv_myTex).rb;
				o.Albedo.g = 1;
			}
		ENDCG
	}

	FallBack "Diffuse"
}