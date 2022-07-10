with Ada.Numerics.Real_Arrays; use Ada.Numerics.Real_Arrays;
with Ada.Strings;              use Ada.Strings;
with Ada.Strings.Bounded;
with Sf.Graphics;

package Ship is
   package CallSignStr is new Ada.Strings.Bounded.Generic_Bounded_Length
     (Max => 6);

   type Ship_Class is (Small, Large);

   type Ship is record
      Pos      : Real_Vector (0 .. 1);
      Vel      : Real_Vector (0 .. 1);
      Waypoint : Real_Vector (0 .. 1);
      Class    : Ship_Class;
      CallSign : CallSignStr.Bounded_String;

      Text : Sf.Graphics.sfText_Ptr;
      Cir  : Sf.Graphics.sfCircleShape_Ptr;
   end record;

   -- Spawn a new ship
   function Spawn
     (Pos : Real_Vector; Class : Ship_Class; CallSign : String) return Ship;

   -- Remove ship's image pointer from memeory
   procedure Destroy (S : Ship);

   -- Update the ship
   procedure Update (S : in out Ship);

   -- Draw the ship on screen
   procedure Draw
     (renderWindow : Sf.Graphics.sfRenderWindow_Ptr; S : Ship;
      F            : Sf.Graphics.sfFont_Ptr);

   procedure Set_Waypoint (S : in out Ship; P : Real_Vector);

end Ship;
