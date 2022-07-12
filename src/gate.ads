with Ada.Numerics.Real_Arrays; use Ada.Numerics.Real_Arrays;
with Sf.Graphics;
package Gate is

   Count : Positive := 1;

   type Gate is record
      Pos       : Real_Vector (0 .. 1);
      Direction : Real_Vector (0 .. 1);
      Number    : Positive;
      Text      : Sf.Graphics.sfText_Ptr;
   end record;

   function Create (Pos : Real_Vector; Direction : Real_Vector) return Gate;

   procedure Destroy (G : Gate);

   procedure Update_Number (G : in out Gate; Number : Positive);

   function Gate_Number (G : Gate) return Positive;

   -- Draw the gate on screen
   procedure Draw
     (renderWindow : Sf.Graphics.sfRenderWindow_Ptr; G : Gate;
      F            : Sf.Graphics.sfFont_Ptr);

end Gate;
