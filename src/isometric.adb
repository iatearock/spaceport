package body Isometric is

   -- Convert world coordinates to screen
   function To_Screen (Vec : Real_Vector) return Real_Vector is
      SX, SY : Float;

   begin

      SX := (Vec (0) - Vec (1)) * Half_Tile_Width;
      SY := (Vec (0) + Vec (1)) * Half_Tile_Height;
      return (SX, SY);
   end To_Screen;

   procedure Set_Tile_Size (S : Float) is 
   begin
    Tile_Size := S;
    end Set_Tile_Size;
end Isometric;
