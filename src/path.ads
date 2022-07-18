with Ada.Containers.Vectors;
with Ada.Numerics.Real_Arrays; use Ada.Numerics.Real_Arrays;

package Path is

   subtype Point is Real_Vector (0 .. 1);

   package Path_Vector is new Ada.Containers.Vectors
     (Index_Type => Natural, Element_Type => Point);

   use Path_Vector;

   procedure Empty (P : Vector);

end Path;
