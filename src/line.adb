with Sf.Graphics.RenderWindow;  use Sf.Graphics.RenderWindow;
with Sf.Graphics.PrimitiveType; use Sf.Graphics.PrimitiveType;
with Sf.Graphics.VertexArray;   use Sf.Graphics.VertexArray;

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

   function World_To_Screen (w : Real_Vector) return Real_Vector is
      s : Real_Vector (w'First .. w'Last);
   begin
      s := Isometric.To_Screen (w);
      return s;
   end World_To_Screen;

   function Vector_To_Vertex (v : Real_Vector; c : sfColor) return sfVertex is
      sv : sfVertex;
   begin
      sv.position := (x => v (v'First), y => v (v'Last));
      sv.color    := c;
      return sv;
   end Vector_To_Vertex;

   function Screen_Line_To_Vertex
     (s : Screen_Line; c : sfColor) return Screen_Vertices
   is
      sv : Screen_Vertices (s'First .. s'Last);
   begin
      for I in s'Range loop
         sv (I) := Vector_To_Vertex (s (I), c);
      end loop;
      return sv;
   end Screen_Line_To_Vertex;

   function Screen_Line_To_Vertex_Arr_Ptr
     (s : Screen_Line; c : sfColor) return Sf.Graphics.sfVertexArray_Ptr
   is
      ptr : Sf.Graphics.sfVertexArray_Ptr;
   begin
      ptr := create;
      setPrimitiveType (ptr, sfLinesStrip);
      for I in s'Range loop
         append (ptr, Vector_To_Vertex (s (I), c));
      end loop;
      return ptr;
   end Screen_Line_To_Vertex_Arr_Ptr;

   function World_Line_To_Vertex_Arr_Ptr
     (w : World_Line; c : sfColor) return Sf.Graphics.sfVertexArray_Ptr
   is
      ptr : Sf.Graphics.sfVertexArray_Ptr;
      SL  : Screen_Line (w'First .. w'Last);
   begin
      ptr := create;
      setPrimitiveType (ptr, sfLinesStrip);
      SL := World_To_Screen (w);
      for I in SL'Range loop
         append (ptr, Vector_To_Vertex (SL (I), c));
      end loop;
      return ptr;
   end World_Line_To_Vertex_Arr_Ptr;

   procedure Draw
     (renderWindow : Sf.Graphics.sfRenderWindow_Ptr;
      vertices     : Screen_Vertices)
   is
      vertex     : aliased sfVertex         := vertices (vertices'First);
      Vertex_Acc : constant access sfVertex := vertex'Access;
   begin
      drawPrimitives
        (renderWindow, Vertex_Acc, vertices'Length, sfLineStrip, null);
   end Draw;

   procedure Draw_World_line
     (renderWindow : Sf.Graphics.sfRenderWindow_Ptr; WL : World_Line;
      c            : sfColor)
   is

      ptr : Sf.Graphics.sfVertexArray_Ptr;
   begin
      ptr := World_Line_To_Vertex_Arr_Ptr (WL, c);
      drawVertexArray (renderWindow, ptr, null);
   end Draw_World_line;

end Line;
