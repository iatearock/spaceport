with Line;
with Isometric;
with Ada.Numerics.Real_Arrays; use Ada.Numerics.Real_Arrays;
with Ada.Text_IO;              use Ada.Text_IO;

with Sf.Graphics.RenderWindow; use Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;         use Sf.Graphics.Text;

package body Draw is

   function RV_To_sfV (V : Real_Vector) return sfVector2f is
   begin
      return (X => V (V'First), Y => V (V'Last));
   end RV_To_sfV;

   function sfV_To_RV (V : sfVector2f) return Real_Vector is
      RV : Real_Vector (0 .. 1);
   begin
      RV := (V.X, V.Y);
      return RV;
   end sfV_To_RV;

   -- Draw Text, apply other setting to T prior to this procedure to apply additional settings
   procedure Text
     (W    : sfRenderWindow_Ptr; T : sfText_Ptr; F : sfFont_Ptr; Str : String;
      Size : sfUint32; Color : sf.Graphics.Color.sfColor; Pos : sfVector2f)
   is
   begin
      setString (T, Str);
      setFont (T, F);
      setCharacterSize (T, Size);
      setPosition (T, Pos);
      setColor (T, Color);

      drawText (W, T);

   end Text;

   procedure Square
     (W   : sfRenderWindow_Ptr; Color : sf.Graphics.Color.sfColor;
      Pos : sfVector2f)
   is

      V_Screen : constant Real_Vector (0 .. 1) := (Pos.X, Pos.Y);
      V : constant Real_Vector (0 .. 1) := Isometric.To_World (V_Screen);

      X : constant Float := V (V'First);
      Y : constant Float := V (V'Last);

      WL : constant Line.World_Line (1 .. 5) :=
        ((X - 0.5, Y - 0.5), (X + 0.5, Y - 0.5), (X + 0.5, Y + 0.5),
         (X - 0.5, Y + 0.5), (X - 0.5, Y - 0.5));

   begin
      Line.Draw_World_Line (W, WL, Color);
   end Square;

end Draw;
