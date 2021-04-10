Shader "Holistic/Cutoff"
{
	SubShader
	{
		CGPROGRAM
			#pragma surface surf Lambert

			struct Input
			{
				float3 viewDir;
				float3 worldPos;
			};
			
			void surf(Input IN, inout SurfaceOutput o)
			{
				half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
				o.Emission = frac(IN.worldPos.y * 10 * 0.5)
					 > 0.6 ? float3(1,0,0) * rim: float3(0,1,0) * rim;
			}

		ENDCG
	}

	FallBack "Diffuse"
}