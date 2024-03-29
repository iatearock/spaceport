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

   -- Convert screen coordinates to world
   function To_World (Vec : Real_Vector) return Real_Vector is
      WX, WY : Float;
   begin
      WX := (Vec (0) / Half_Tile_Width + Vec (1) / Half_Tile_Height) / 2.0;
      WY := (Vec (1) / Half_Tile_Height - (Vec (0) / Half_Tile_Width)) / 2.0;
      return (WX, WY);
   end To_World;

   -- nearest tile is the same as nearest integer (in world coord)
   function Nearest_Tile (Vec : Real_Vector) return Real_Vector is
      X, Y : Integer;
      RV   : Real_Vector (0 .. 1);
   begin
      X  := Integer (Vec (Vec'First));
      Y  := Integer (Vec (Vec'Last));
      RV := (Float (X), Float (Y));
      return RV;
   end Nearest_Tile;

   -- convert mouse coord to screen coord at nearest tile
   function Mouse_To_Tile (Vec : Real_Vector) return Real_Vector is
   begin
      return To_Screen (Nearest_Tile (To_World (Vec)));
   end Mouse_To_Tile;

end Isometric;
