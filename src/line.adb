-- with Ada.Numerics.Real_Arrays; use Ada.Numerics.Real_Arrays;
with Ada.Text_IO;
-- with Sf.Graphics; use Sf.Graphics;
-- with Sf.Graphics.Vertex;        use Sf.Graphics.Vertex;
with Sf.Graphics.RenderWindow;  use Sf.Graphics.RenderWindow;
with Sf.System.Vector2;         use Sf.System.Vector2;
with Sf.Graphics.Color;         use Sf.Graphics.Color;
with Sf.Graphics.PrimitiveType; use Sf.Graphics.PrimitiveType;

with Isometric;

package body Line is

   function World_To_Screen (w : World_Line) return Screen_Line is
      s : Screen_Line (w'First .. w'Last);
   begin
      for I in w'Range loop
         s (I) := Isometric.To_Screen (w (I));
      end loop;
      return s;
   end World_To_Screen;

   function Vector_To_Vertex (v : Real_Vector) return sfVertex is
      sv : sfVertex;
   begin
      sv.position := (x => v (v'First), y => v (v'Last));
      sv.color    := sfWhite;
      return sv;
   end Vector_To_Vertex;

   function Line_To_Vertex (s : Screen_Line) return Screen_Vertices is
      sv : Screen_Vertices (s'First .. s'Last);
   begin
      for I in s'Range loop
         sv (I) := Vector_To_Vertex (s (I));
      end loop;
      return sv;
   end Line_To_Vertex;

   function Line_To_Vertex_Arr_Ptr
     (s : Screen_Line) return Sf.Graphics.sfVertexArray_Ptr
   is
      ptr : Sf.Graphics.sfVertexArray_Ptr;
   begin
      ptr := create;
      setPrimitiveType (ptr, sfLinesStrip);
      for I in s'Range loop
         append (ptr, Vector_To_Vertex (s (I)));
      end loop;
      return ptr;
   end Line_To_Vertex_Arr_Ptr;

   procedure Draw
     (renderWindow : Sf.Graphics.sfRenderWindow_Ptr;
      vertices     : Screen_Vertices)
   is
      vertex     : aliased sfVertex := vertices (vertices'First);
      Vertex_Acc : access sfVertex  := vertex'Access;
   begin
      drawPrimitives
        (renderWindow, Vertex_Acc, vertices'Length, sfLineStrip, null);
   end Draw;

end Line;
