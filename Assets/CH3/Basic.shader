Shader "Holistic/Basic"
{
	Properties
	{
		_myDiffuse("Main Texture", 2D) = "white"{}
	}

	SubShader
	{
		Tags{"Queue" = "Geometry+100"}
		ZWrite Off

		CGPROGRAM
		
			sampler2D _myDiffuse;
			
			#pragma surface surf Lambert

			struct Input
			{
				float2 uv_myDiffuse;
			};
			
			void surf(Input IN, inout SurfaceOutput o)
			{
				o.Albedo = tex2D(_myDiffuse, IN.uv_myDiffuse);
			}
			
			
		ENDCG
	}

	Fallback "Diffuse"
}