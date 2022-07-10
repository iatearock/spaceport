with Ada.Numerics.Real_Arrays; use Ada.Numerics.Real_Arrays;

with Sf.Graphics;
with Sf.Graphics.Vertex; use Sf.Graphics.Vertex;

package Line is

   type World_Line is array (Integer range <>) of Real_Vector (0 .. 1);
   type Screen_Line is array (Integer range <>) of Real_Vector (0 .. 1);
   type Screen_Vertices is array (Integer range <>) of sfVertex;

   -- Convert list of world vector to screen coordinates
   function World_To_Screen (w : World_Line) return Screen_Line;
   -- Convert a vector to sfml vertex
   function Vector_To_Vertex (v : Real_Vector) return sfVertex;
   -- Convert list of screen coordinates to sfml vertex
   function Line_To_Vertex (s : Screen_Line) return Screen_Vertices;
   -- Convert list of screen coordinates to sfml vertex pointer
   function Line_To_Vertex_Arr_Ptr
     (s : Screen_Line) return Sf.Graphics.sfVertexArray_Ptr;

   -- Draw a vertex array to screen
   procedure Draw
     (renderWindow : Sf.Graphics.sfRenderWindow_Ptr;
      vertices     : Screen_Vertices);

end Line;
