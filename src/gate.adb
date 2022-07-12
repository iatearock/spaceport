with Line;
with Sf.Graphics.Color;        use Sf.Graphics.Color;
with Sf.Graphics.Text;         use Sf.Graphics.Text;
with Sf.Graphics.RenderWindow; use Sf.Graphics.RenderWindow;
package body Gate is

   function Create (Pos : Real_Vector; Direction : Real_Vector) return Gate is

      G : Gate;
   begin
      G := (Pos => Pos, Direction => Direction, Number => Count, Text => null);
      G.Text := create;
      setString (G.Text, G.Number'Image);
      setCharacterSize (G.Text, 10);
      setColor (G.Text, sfGreen);
      Count := Count + 1;
      return G;
   end Create;

   procedure Destroy (G : Gate) is
   begin
      destroy (G.Text);
   end Destroy;

   procedure Update_Number (G : in out Gate; Number : Positive) is
   begin
      G.Number := Number;
   end Update_Number;

   function Gate_Number (G : Gate) return Positive is

   begin
      return G.Number;
   end Gate_Number;

   procedure Draw
     (renderWindow : Sf.Graphics.sfRenderWindow_Ptr; G : Gate;
      F            : Sf.Graphics.sfFont_Ptr)
   is

      X : constant Float := G.Pos (G.Pos'First);
      Y : constant Float := G.Pos (G.Pos'Last);

      WL : constant Line.World_Line (1 .. 5) :=
        ((X - 0.5, Y - 0.5), (X + 0.5, Y - 0.5), (X + 0.5, Y + 0.5),
         (X - 0.5, Y + 0.5), (X - 0.5, Y - 0.5));
      --  SL         : Line.Screen_Line (1 .. 5);
      --  Vertex_Ptr : Sf.Graphics.sfVertexArray_Ptr;

   begin
      Line.Draw_World_Line (renderWindow, WL, sfGreen);

      setFont (G.Text, F);
      setPosition (G.Text, (X, Y));
      drawText (renderWindow, G.Text, null);

   end Draw;

end Gate;
