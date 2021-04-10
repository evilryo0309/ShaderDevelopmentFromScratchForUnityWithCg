Shader "Holistic/UVScrollWaterWaves"
{
	Properties
	{
		_MainTex("Water", 2D) = "white" {}
		_FoamTex("Foam", 2D) = "white" {}
		_Tint("Colour Tint", Color) = (1,1,1,1)
		_Freq("Frequency", Range(0,5)) = 3
		_Speed("Speed",Range(0,100)) = 10
		_Amp("Amplitude",Range(0,1)) = 0.5
		_ScrollX("ScrollX", Range(-5,5)) = 1
		_ScrollY("ScrollY", Range(-5,5)) = 1
	}
	SubShader
	{
		CGPROGRAM

		#pragma surface surf Lambert vertex:vert

		struct appdata
		{
			float4 vertex : POSITION;
			float3 normal : NORMAL;
			float2 texcoord : TEXCOORD0;
			float2 texcoord1 : TEXCOORD1;
			float2 texcoord2 : TEXCOORD2;
		};

		struct Input
		{
			float2 uv_MainTex;
			float3 vertColor;
		};

		float4 _Tint;
		float _Freq;
		float _Speed;
		float _Amp;

		void vert(inout appdata v, out Input o)
		{
			UNITY_INITIALIZE_OUTPUT(Input,o);
			float t = _Time * _Speed;
			float waveHeight = sin(t + v.vertex.x * _Freq) * _Amp +
				sin(t * 2 + v.vertex.x * _Freq * 2) * _Amp;
			v.vertex.y = v.vertex.y + waveHeight;
			v.normal = normalize(float3(v.normal.x + waveHeight, v.normal.y, v.normal.z));
			o.vertColor = waveHeight + 2;
		}

		sampler2D _MainTex;
		sampler2D _FoamTex;
		float _ScrollX;
		float _ScrollY;

		void surf(Input IN, inout SurfaceOutput o)
		{
			_ScrollX *= _Time;
			_ScrollY *= _Time;
			fixed4 water = tex2D(_MainTex, IN.uv_MainTex + float2(_ScrollX, _ScrollY));
			fixed4 foam = tex2D(_FoamTex, IN.uv_MainTex + float2(_ScrollX, _ScrollY) / 2);
			o.Albedo = (water + foam) / 2.4;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
