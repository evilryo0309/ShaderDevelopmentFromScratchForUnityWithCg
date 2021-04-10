Shader "Holistic/Rim"
{
	Properties
	{
		_rimColor("Rim Color", Color) = (0, 0.5, 0.5, 0)
		_rimPower("Rim Power", Range(0.5, 8)) = 3.0
	}

	SubShader
	{
		CGPROGRAM
			#pragma surface surf Lambert

			float4 _rimColor;
			float _rimPower;

			struct Input
			{
				float3 viewDir;
			};
			
			void surf(Input IN, inout SurfaceOutput o)
			{
				half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
				o.Emission = _rimColor.rgb * pow(rim, _rimPower);
			}

		ENDCG
	}

	Fallback "Diffuse"
}