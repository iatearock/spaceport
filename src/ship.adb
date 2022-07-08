with Sf.System.Vector2;        use Sf.System.Vector2;
with Sf.Graphics.RenderWindow; use Sf.Graphics.RenderWindow;
with Sf.Graphics.Color;
with Line;
package body Ship is

   function Spawn
     (Pos : Real_Vector; Class : Ship_Class; CallSign : String) return Ship
   is
      S   : Ship;
      Rad : constant Float := 5.0;
   begin
      S :=
        (Pos      => Pos, Vel => (0.0, 0.0), Class => Class,
         CallSign => CallSignStr.To_Bounded_String (CallSign), Cir => null,
         Text     => null);
      S.Cir := create;
      setRadius (S.Cir, Rad);
      setOrigin (S.Cir, (Rad / 2.0, Rad / 2.0));
      setPointCount (S.Cir, 12);
      setOutlineColor(S.Cir, sf.Graphics.Color.sfWhite);
      setOutlineThickness(S.Cir, 1.0);
      setFillColor(S.Cir, sf.Graphics.Color.sfTransparent);
      setPosition (S.Cir, (Pos (Pos'First), Pos (Pos'Last)));
      S.Text := create;
      setString (S.Text, CallSign);
      setCharacterSize (S.Text, 10);
      return S;
   end Spawn;

   procedure Destroy (S : Ship) is
   begin
      destroy (S.Cir);
   end Destroy;

   -- Move the ship
   procedure Move (S : in out Ship) is
   begin
      S.Pos := S.Pos + S.Vel * (1.0 / 60.0);
   end Move;

   -- Draw the ship on screen
   procedure Draw
     (renderWindow : Sf.Graphics.sfRenderWindow_Ptr; S : Ship;
      F            : Sf.Graphics.sfFont_Ptr)
   is
      Vec : sfVector2f;
      Leader : Line.Screen_Line (0..1);
      Vertex_Ptr : sf.Graphics.sfVertexArray_Ptr;

   begin
      Vec := ((S.Pos (S.Pos'First), S.Pos (S.Pos'Last)));
      Leader := ((Vec.x + 2.5, Vec.y + 2.5), (Vec.x + 20.0, Vec.y + 10.0));
      Vertex_Ptr := Line.Line_To_Vertex_Arr_Ptr(Leader);
      setPosition (S.Cir, Vec);
      drawCircleShape (renderWindow, S.Cir, null);
      setFont (S.Text, F);
      setPosition (S.Text, (Vec.x + 20.0, Vec.y + 10.0));
      drawText (renderWindow, S.Text, null);
      drawVertexArray (renderWindow, Vertex_Ptr, null);
   end Draw;

end Ship;
