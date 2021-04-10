Shader "Holistic/BasicBlinnCustomLight"
{
	Properties 
	{
		_Color ("Color", Color) = (1,1,1,1)
	}
	SubShader
	{
		Tags
		{
			"Queue" = "Geometry"
		}

		CGPROGRAM
		#pragma surface surf BasicBlinn

		struct Input 
		{
			float2 uv_MainTex;
		};

		fixed4 _Color;

		void surf (Input IN, inout SurfaceOutput o)
		{
			o.Albedo.rgb = _Color.rgb;
		}

		half4 LightingBasicBlinn(SurfaceOutput s, half3 lightDir, half viewDir, half atten)
		{
			half3 h = normalize(lightDir + viewDir);

			half diff = max(0, dot(s.Normal, lightDir));

			float nh = max(0, dot(s.Normal, h));
			float spec = pow(nh, 48.0);

			half4 c;
			//c.rgb = (s.Albedo * _LightColor0.rgb * diff + _LightColor0.rgb * spec) * atten;
			c.rgb = (s.Albedo * _LightColor0.rgb * diff + _LightColor0.rgb * spec) * atten * _SinTime;
			c.a = s.Alpha;
			return c;
		}

		ENDCG
	}
	FallBack "Diffuse"
}
