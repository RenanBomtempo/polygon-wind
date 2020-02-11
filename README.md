# Polygon Wind Shader
In 2017 I was looking for a wind shader to use on a low poly tree model. I couldn't find one that provided the visual I was looking for, so I started to develop the Polygon Wind Shader. 

It is designed to generate a more suttle and organic wind movement on trees. But it's not great for heavy wind effects.
**Lately I haven't had much time to work on it, so I decided to publish the source code here and make it available so that anyone can use and modify it.**

Here are some videos of what I achieved using it:

  - Using on individual model: https://youtu.be/nG-dmBiyHXc
  - Using on a Unity Terrain: https://youtu.be/CGLFoZXgCKA

## How to use it:

Just apply the shader to a material and apply the material to your asset. The ideal tree asset is one with a single mesh.

The shader has various parameters for you to tweak:
  - Wind Wave Size;
  - Tree Sway Displacement;
  - Foliage Wiggle Amount;
  - Branches Up/Down;
  - Foliage Wiggle Speed;
  - Tree Sway Stutter;
  - Tree Sway Speed;
  - Wind Direction;
  - Red Vertex Influence;
  - Blue Vertex Influence.
  
It uses a series of inputs to calculate the final vertex position, one of them being the vertices colors of the mesh:

  - Red - Use on the branches to enable the up/down movement;
  - Blue - Use it on the leaves to get that organic wiggle.
