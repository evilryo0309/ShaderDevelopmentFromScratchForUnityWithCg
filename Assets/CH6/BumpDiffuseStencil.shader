Shader "Holistic/BumpDiffuseStencil"
{
	Properties
	{
		_Color("Color", Color) = (1, 1, 1, 1)
		_Diffuse("Diffuse", 2D) = "white"{}
		_Bump("Bump", 2D) = "bump"{}
		_BumpAmount("Bump Amount", Range(0, 8)) = 1
		_SRef("Stencil Ref", Float) = 1
		[Enum(UnityEngine.Rendering.CompareFunction)] _SComp("Stencil Comp", Float) = 8
		[Enum(UnityEngine.Rendering.StencilOp)] _SOp("Stencil Op", Float) = 2
	}

	SubShader
	{
		Stencil
		{
			Ref[_SRef]
			Comp[_SComp]
			Pass[_SOp]
		}

		CGPROGRAM

		#pragma surface surf Lambert

		struct Input
		{
			float2 uv_Diffuse;
			float2 uv_Bump;
		};

		half4 _Color;
		sampler2D _Diffuse;
		sampler2D _Bump;
		float _BumpAmount;

		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_Diffuse, IN.uv_Diffuse).rgb * _Color;
			o.Normal = UnpackNormal(tex2D(_Bump, IN.uv_Bump)).rgb;
			o.Normal *= float3(_BumpAmount, _BumpAmount, 1);
		}

		ENDCG
	}

	Fallback "Diffuse"
}