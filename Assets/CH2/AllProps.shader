Shader "Holistic/AllProps"
{
	Properties
	{
		_myColor ("MyColor", Color) = (1, 1, 1, 1)
		_myRange ("MyRange", Range(0,5)) = 1
		_myTex ("MyTex", 2D) = "White"{}
		_myCube ("MyCube", Cube) = ""{}
		_myFloat ("MyFloat", Float) = 0.5
		_myVector ("MyVector", Vector) = (0.5, 1, 1, 1)
	}

	SubShader
	{
		CGPROGRAM
			#pragma surface surf Lambert
			
			struct Input
			{
				float2 uv_myTex;
				float3 worldRefl;
			};

			fixed4 _myColor;
			half _myRange;
			sampler2D _myTex;
			samplerCUBE _myCube;
			float _myFloat;
			float4 _myVector;

			void surf(Input IN, inout SurfaceOutput o)
			{
				o.Albedo = (tex2D(_myTex, IN.uv_myTex) * _myRange * _myColor).rgb;
				o.Emission = texCUBE(_myCube, IN.worldRefl).rgb;
			}

		ENDCG
	}

	FallBack "Diffuse"
}