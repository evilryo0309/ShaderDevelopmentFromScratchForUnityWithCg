Shader "Holistic/CutoffWithDiffuse"
{
	Properties
	{
		_myDiffuse("Diffuse Texture",2D) = "white"{}
		_stripeWidth("Stripe Width", Range(1,20)) = 10
	}

	SubShader
	{
		CGPROGRAM
			#pragma surface surf Lambert

			struct Input
			{
				float2 uv_myDiffuse;
				float3 viewDir;
				float3 worldPos;
			};
			
			sampler2D _myDiffuse;
			half _stripeWidth;

			void surf(Input IN, inout SurfaceOutput o)
			{
				o.Albedo = tex2D(_myDiffuse, IN.uv_myDiffuse);
				half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
				o.Emission = frac(IN.worldPos.y * (20-_stripeWidth) * 0.5)
					 > 0.4 ? float3(0,1,0) * rim: float3(1,0,0) * rim;
			}

		ENDCG
	}

	FallBack "Diffuse"
}