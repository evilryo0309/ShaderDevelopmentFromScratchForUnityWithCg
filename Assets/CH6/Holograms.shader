Shader "Holistic/Holograms"
{
	Properties
	{
		_RimColor("Rim Color", COLOR) = (0, 0, 0, 0)
		_RimPower("Rim Power", Range(0.5, 8)) = 1
	}

	SubShader
	{
		Tags
		{
			"Queue" = "Transparent"
		}

		Pass
		{
			ZWrite On
			ColorMask 0
		}
		

		CGPROGRAM

		#pragma surface surf Lambert alpha:fade

		float4 _RimColor;
		float _RimPower;

		struct Input
		{
			float3 viewDir;
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
			half3 rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
			o.Emission.rgb = _RimColor.rgb * pow(rim, _RimPower) * 10;
			o.Alpha = pow(rim, _RimPower);
		}

		ENDCG
	}

	Fallback "Diffuse"
}