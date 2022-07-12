with Ada.Numerics.Real_Arrays; use Ada.Numerics.Real_Arrays;
with Sf.Graphics.Color;        use Sf.Graphics.Color;
with Sf.Graphics;
with Sf.Graphics.Vertex;       use Sf.Graphics.Vertex;

package Line is

   type World_Line is array (Integer range <>) of Real_Vector (0 .. 1);
   type Screen_Line is array (Integer range <>) of Real_Vector (0 .. 1);
   type Screen_Vertices is array (Integer range <>) of sfVertex;

   -- Convert list of world vector to screen coordinates
   function World_To_Screen (w : World_Line) return Screen_Line;
   -- Convert list of world vector to screen vector
   function World_To_Screen (w : Real_Vector) return Real_Vector;
   -- Convert a vector to sfml vertex
   function Vector_To_Vertex (v : Real_Vector; c : sfColor) return sfVertex;
   -- Convert list of screen coordinates to sfml vertex
   function Screen_Line_To_Vertex
     (s : Screen_Line; c : sfColor) return Screen_Vertices;
   -- Convert list of screen coordinates to sfml vertex pointer
   function Screen_Line_To_Vertex_Arr_Ptr
     (s : Screen_Line; c : sfColor) return Sf.Graphics.sfVertexArray_Ptr;
   function World_Line_To_Vertex_Arr_Ptr
     (w : World_Line; c : sfColor) return Sf.Graphics.sfVertexArray_Ptr;

   -- Draw a vertex array to screen
   procedure Draw
     (renderWindow : Sf.Graphics.sfRenderWindow_Ptr;
      vertices     : Screen_Vertices);
   -- Draw a world line to screen
   procedure Draw_World_Line
     (renderWindow : Sf.Graphics.sfRenderWindow_Ptr; WL : World_Line;
      c            : sfColor);
end Line;
