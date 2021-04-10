Shader "Holistic/BumpReflection"
{
	Properties
	{
		_myBump("Bump Texture", 2D) = "bump"{}
		_myCube("Cube Map", CUBE) = "white"{}
	}

	SubShader
	{
		CGPROGRAM

			#pragma surface surf Lambert

			sampler2D _myBump;
			samplerCUBE _myCube;

			struct Input
			{
				float2 uv_myBump;
				float3 worldRefl; INTERNAL_DATA
			};

			void surf(Input IN, inout SurfaceOutput o)
			{
				o.Normal = UnpackNormal(tex2D(_myBump, IN.uv_myBump)) * 0.3;

				//範例參考答案
				//o.Albedo = texCUBE(_myCube, WorldReflectionVector(IN, o.Normal));

				//目前覺得這個寫法比較金屬感
				o.Albedo = texCUBE(_myCube, IN.worldRefl);
			}

		ENDCG
	}

	FallBack "Diffuse"
}