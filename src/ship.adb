with Sf.System.Vector2;        use Sf.System.Vector2;
with Sf.Graphics.RenderWindow; use Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;         use Sf.Graphics.Text;
with Sf.Graphics.CircleShape;  use Sf.Graphics.CircleShape;
with Sf.Graphics.Color;        use Sf.Graphics.Color;
with Line;
with Ada.Text_IO;              use Ada.Text_IO;
package body Ship is
   Counter : Integer := 1;

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
      setOutlineThickness (S.Cir, 2.0);
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
      destroy (S.Text);
   end Destroy;

   -- Update the ship
   procedure Update (S : in out Ship) is
      Displayment : Float;
      Delta_Vec   : Real_Vector (0 .. 1);
   begin
      Displayment := abs (S.Vel) * (1.0 / 60.0);
      Delta_Vec   := S.Waypoint - S.Pos;
      S.Vel       := Speed (S.Class) * (Delta_Vec / abs (Delta_Vec));
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
      RV         : Real_Vector (0 .. 1);
      Vec2       : sfVector2f;
      RV2        : Real_Vector (0 .. 1);
      Leader     : Line.World_Line (0 .. 1);
      Vertex_Ptr : Sf.Graphics.sfVertexArray_Ptr;

   begin
      Vec    := ((S.Pos (S.Pos'First), S.Pos (S.Pos'Last)));
      Leader := ((Vec.x, Vec.y), (Vec.x + 4.5, Vec.y + 0.0));
      Line.Draw_World_Line (renderWindow, Leader, sfWhite);
      RV   := Line.World_To_Screen (S.Pos);
      RV2  := Line.World_To_Screen (Leader (Leader'Last));
      Vec  := ((RV (RV'First), RV (RV'Last)));
      Vec2 := ((RV2 (RV2'First), RV2 (RV2'Last)));

      setPosition (S.Cir, Vec);
      drawCircleShape (renderWindow, S.Cir, null);
      setFont (S.Text, F);
      setPosition (S.Text, Vec2);
      drawText (renderWindow, S.Text, null);
      --  drawVertexArray (renderWindow, Vertex_Ptr, null);
   end Draw;

   procedure Set_Waypoint (S : in out Ship; P : Real_Vector) is
   begin
      S.Waypoint := P;
   end Set_Waypoint;

   function Speed (ShipClass : Ship_Class) return Float is
   begin
      case ShipClass is
         when Small =>
            return 5.0;
         when Large =>
            return 3.0;
         when others =>
            return 0.0;
      end case;
   end Speed;

end Ship;
