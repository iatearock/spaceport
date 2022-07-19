with Ada.Numerics.Real_Arrays; use Ada.Numerics.Real_Arrays;
package Isometric is

   Tile_Size        : Float := 32.0;
   Half_Tile_Width  : Float := Tile_Size / 2.0;
   Half_Tile_Height : Float := Half_Tile_Width / 2.0;

   -- Convert world coordinates to screen
   function To_Screen (Vec : Real_Vector) return Real_Vector;
   procedure Set_Tile_Size (S : Float);
   function To_World (Vec : Real_Vector) return Real_Vector;

   -- Round coordiantes to integer
   function Nearest_Tile (Vec : Real_Vector) return Real_Vector;

   -- Take mouse coordinates, and return nearest tile screencoordinates
   function Mouse_To_Tile (Vec : Real_Vector) return Real_Vector;

end Isometric;
