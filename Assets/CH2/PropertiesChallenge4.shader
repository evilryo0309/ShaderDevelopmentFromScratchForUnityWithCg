Shader "Holistic/PropertiesChallenge4"
{
	Properties
	{
		_myAlbedoTex ("Albedo", 2D) = "white"{}
		_myEmissionTex ("Emission", 2D) = "black"{}
	}

	SubShader
	{
		CGPROGRAM
			#pragma surface surf Lambert

			sampler2D _myAlbedoTex;
			sampler2D _myEmissionTex;

			struct Input
			{
				float2 uv_myAlbedoTex;
				float2 uv_myEmissionTex;
			};

			void surf(Input IN, inout SurfaceOutput o)
			{
				o.Albedo = tex2D(_myAlbedoTex, IN.uv_myAlbedoTex);
				o.Emission = tex2D(_myEmissionTex, IN.uv_myEmissionTex);
			}
			
		ENDCG
	}

	FallBack "Diffuse"
}