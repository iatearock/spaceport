with Sf; use Sf;

with Sf.Graphics.Color;
use Sf.Graphics, Sf.Graphics.Color;
with Sf.System.Vector2; use Sf.System.Vector2;

with Ada.Numerics.Real_Arrays; use Ada.Numerics.Real_Arrays;

with Path;

package Draw is

   function RV_To_sfV (V : Real_Vector) return sfVector2f;
   function sfV_To_RV (V : sfVector2f) return Real_Vector;

   procedure Text
     (W    : sfRenderWindow_Ptr; T : sfText_Ptr; F : sfFont_Ptr; Str : String;
      Size : sfUint32; Color : sf.Graphics.Color.sfColor; Pos : sfVector2f);

   procedure Square
     (W   : sfRenderWindow_Ptr; Color : sf.Graphics.Color.sfColor;
      Pos : sfVector2f);

   procedure PathVector
     (W : sfRenderWindow_Ptr; Color : sf.Graphics.Color.sfColor;
      P : Path.Path_Vector.Vector);

end Draw;
