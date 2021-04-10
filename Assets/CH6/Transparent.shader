Shader "Holistic/Transparent"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white"
	}

	SubShader
	{
		Tags{ "Queue" = "Transparent"}
		Blend SrcAlpha OneMinusSrcAlpha
		Cull Off
		Pass
		{
			SetTexture[_MainTex]{ combine texture}
		}
	}

	Fallback "Diffuse"
}