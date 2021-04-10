Shader "Holistic/Hole"
{
	Properties
	{
		_MainTex("Albedo (RGB)", 2D) = "white" {}
	}

	SubShader
	{
		Tags{ "Queue" = "Geometry-1" }

		ColorMask 0
		ZWrite Off

		Stencil
		{
			//參考值: 1
			Ref 1

			//比較方式: 總是
			Comp always

			//條件成立時: 將referenceValue(1)寫入stencilBuffer
			Pass replace
		}

		CGPROGRAM

		#pragma surface surf Lambert

		sampler2D _MainTex;

		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
		}

		ENDCG
	}
	FallBack "Diffuse"
}
