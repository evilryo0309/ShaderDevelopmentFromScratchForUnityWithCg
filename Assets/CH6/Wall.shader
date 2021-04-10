Shader "Holistic/Wall" 
{
	Properties 
	{
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
	}

	SubShader
	{
		Tags { "Queue" = "Geometry" }

		Stencil
		{
			//參考值: 1
			Ref 1

			//比較方式: 當不一樣時
			Comp notequal

			//條件成立時: 保留當前緩衝中的內容，即stencilBufferValue不變。
			Pass keep
		}

		CGPROGRAM

		#pragma surface surf Lambert

		sampler2D _MainTex;

		struct Input
		{
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) 
		{
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
