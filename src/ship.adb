with Sf.System.Vector2;        use Sf.System.Vector2;
with Sf.Graphics.RenderWindow; use Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;         use Sf.Graphics.Text;
with Sf.Graphics.CircleShape;  use Sf.Graphics.CircleShape;
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
        (Pos      => Pos, Vel => (0.0, 0.0), Waypoint => Pos, Class => Class,
         CallSign => CallSignStr.To_Bounded_String (CallSign), Cir => null,
         Text     => null);
      S.Cir := create;
      setRadius (S.Cir, Rad);
      setOrigin (S.Cir, (Rad / 2.0, Rad / 2.0));
      setPointCount (S.Cir, 12);
      setOutlineColor (S.Cir, Sf.Graphics.Color.sfWhite);
      setOutlineThickness (S.Cir, 1.0);
      setFillColor (S.Cir, Sf.Graphics.Color.sfTransparent);
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

   -- Update the ship
   procedure Update (S : in out Ship) is
      Displayment : Float;
      Delta_Vec   : Real_Vector (0 .. 1);
   begin
      Displayment := abs (S.Vel) * (1.0 / 60.0);
      Delta_Vec   := S.Waypoint - S.Pos;
      S.Vel   := S.Waypoint - S.Pos;
      if abs (Delta_Vec) > Displayment then
         S.Pos := S.Pos + S.Vel * (1.0 / 60.0);
      end if;
   end Update;

   -- Draw the ship on screen
   procedure Draw
     (renderWindow : Sf.Graphics.sfRenderWindow_Ptr; S : Ship;
      F            : Sf.Graphics.sfFont_Ptr)
   is
      Vec        : sfVector2f;
      Leader     : Line.Screen_Line (0 .. 1);
      Vertex_Ptr : Sf.Graphics.sfVertexArray_Ptr;

   begin
      Vec        := ((S.Pos (S.Pos'First), S.Pos (S.Pos'Last)));
      Leader     := ((Vec.x + 2.5, Vec.y + 2.5), (Vec.x + 20.0, Vec.y + 10.0));
      Vertex_Ptr := Line.Line_To_Vertex_Arr_Ptr (Leader);
      setPosition (S.Cir, Vec);
      drawCircleShape (renderWindow, S.Cir, null);
      setFont (S.Text, F);
      setPosition (S.Text, (Vec.x + 20.0, Vec.y + 10.0));
      drawText (renderWindow, S.Text, null);
      drawVertexArray (renderWindow, Vertex_Ptr, null);
   end Draw;

   procedure Set_Waypoint (S : in out Ship; P : Real_Vector) is
   begin
      S.Waypoint := p;
   end Set_Waypoint;
end Ship;
