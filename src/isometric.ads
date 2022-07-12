with Ada.Numerics.Real_Arrays; use Ada.Numerics.Real_Arrays;
package Isometric is

   Tile_Size        : Float := 64.0;
   Half_Tile_Width  : Float := Tile_Size / 2.0;
   Half_Tile_Height : Float := Half_Tile_Width / 2.0;

   -- Convert world coordinates to screen
   function To_Screen (Vec : Real_Vector) return Real_Vector;
   procedure Set_Tile_Size (S : Float);

end Isometric;
