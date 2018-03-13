//--------------------------------------Copyright-------------------------------------//
// Copyright 2018 Renan Bomtempo
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in compliance with the License.
//   You may obtain a copy of the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS,
//   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//   See the License for the specific language governing permissions and
//   limitations under the License.
//--------------------------------------Copyright-------------------------------------//

// Polygon Wind - Tree v0.8.2

// Parameters:
// - Wind Direction;
// - Wind Wave Size;
// - Tree Sway Speed;
// - Tree Sway Displacement;
// - Tree Sway Stutter;
// - Foliage Wiggle Amount;
// - Foliage Wiggle Speed;
// - Branches Up/Down;
// - Red Vertex Influence;
// - Blue Vertex Influence.

// Originaly developed by: Renan Bomtempo
// (https://www.behance.net/renanBomtempo)

Shader "Polygon Wind/Tree" {
 
    Properties {
        _MainTex ("Main Texture", 2D) = "white" {}
        _Tint ("Tint", Color) = (1,1,1,1)

        _wind_dir ("Wind Direction", Vector) = (0.5,0.05,0.5,0)
        _wind_size ("Wind Wave Size", range(5,50)) = 15

        _tree_sway_stutter_influence("Tree Sway Stutter Influence", range(0,1)) = 0.2
        _tree_sway_stutter ("Tree Sway Stutter", range(0,10)) = 1.5
        _tree_sway_speed ("Tree Sway Speed", range(0,10)) = 1
        _tree_sway_disp ("Tree Sway Displacement", range(0,1)) = 0.3

        _branches_disp ("Branches Displacement", range(0,0.5)) = 0.3

        _leaves_wiggle_disp ("Leaves Wiggle Displacement", float) = 0.07
        _leaves_wiggle_speed ("Leaves Wiggle Speed", float) = 0.01

        _r_influence ("Red Vertex Influence", range(0,1)) = 1
        _b_influence ("Blue Vertex Influence", range(0,1)) = 1

    }
 
    SubShader {
        
        CGPROGRAM
        #pragma target 3.0
        #pragma surface surf Lambert vertex:vert addshadow

            //Declared Variables
            float4 _wind_dir;
            float _wind_size;
            float _tree_sway_speed;
            float _tree_sway_disp;
            float _leaves_wiggle_disp;
            float _leaves_wiggle_speed;
            float _branches_disp;
            float _tree_sway_stutter;
            float _tree_sway_stutter_influence;
            float _r_influence;
            float _b_influence;

            sampler2D _MainTex;
            fixed4 _Tint;

                //Structs
                struct Input {
                    float2 uv_MainTex;
                };

                // Vertex Manipulation Function
                void vert (inout appdata_full i) {

                     //Gets the vertex's World Position 
                    float3 worldPos = mul (unity_ObjectToWorld, i.vertex).xyz;

                    //Tree Movement and Wiggle
                    i.vertex.x += (cos(_Time.z * _tree_sway_speed + (worldPos.x/_wind_size) + (sin(_Time.z * _tree_sway_stutter * _tree_sway_speed + (worldPos.x/_wind_size)) * _tree_sway_stutter_influence) ) + 1)/2 * _tree_sway_disp * _wind_dir.x * (i.vertex.y / 10) + 
                    cos(_Time.w * i.vertex.x * _leaves_wiggle_speed + (worldPos.x/_wind_size)) * _leaves_wiggle_disp * _wind_dir.x * i.color.b * _b_influence;

                    i.vertex.z += (cos(_Time.z * _tree_sway_speed + (worldPos.z/_wind_size) + (sin(_Time.z * _tree_sway_stutter * _tree_sway_speed + (worldPos.z/_wind_size)) * _tree_sway_stutter_influence) ) + 1)/2 * _tree_sway_disp * _wind_dir.z * (i.vertex.y / 10) + 
                    cos(_Time.w * i.vertex.z * _leaves_wiggle_speed + (worldPos.x/_wind_size)) * _leaves_wiggle_disp * _wind_dir.z * i.color.b * _b_influence;

                    i.vertex.y += cos(_Time.z * _tree_sway_speed + (worldPos.z/_wind_size)) * _tree_sway_disp * _wind_dir.y * (i.vertex.y / 10);

                    //Branches Movement
                    i.vertex.y += sin(_Time.w * _tree_sway_speed + _wind_dir.x + (worldPos.z/_wind_size)) * _branches_disp  * i.color.r * _r_influence;

                }

                // Surface Shader
                void surf (Input IN, inout SurfaceOutput o) {
                    fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Tint;
                    o.Albedo = c.rgb;
                    o.Alpha = c.a;
                }

        ENDCG
        }
     
    Fallback "Diffuse"
} 
