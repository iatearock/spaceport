with Ada.Numerics.Real_Arrays; use Ada.Numerics.Real_Arrays;

with Sf.Graphics;
with Sf.Graphics.Vertex;      use Sf.Graphics.Vertex;
with Sf.Graphics.VertexArray; use Sf.Graphics.VertexArray;

package Line is

   type World_Line is array (Integer range <>) of Real_Vector (0 .. 1);
   type Screen_Line is array (Integer range <>) of Real_Vector (0 .. 1);
   type Screen_Vertices is array (Integer range <>) of sfVertex;

   function World_To_Screen (w : World_Line) return Screen_Line;
   function Vector_To_Vertex (v : Real_Vector) return sfVertex;
   function Line_To_Vertex (s : Screen_Line) return Screen_Vertices;
   function Line_To_Vertex_Arr_Ptr
     (s : Screen_Line) return Sf.Graphics.sfVertexArray_Ptr;

   procedure Draw
     (renderWindow : Sf.Graphics.sfRenderWindow_Ptr;
      vertices     : Screen_Vertices);

end Line;
