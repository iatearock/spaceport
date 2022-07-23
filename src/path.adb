with Ada.Text_IO; use Ada.Text_IO;
package body Path is

   function Create return Path_Vector.Vector is
   begin
      return Path_Vector.Empty_Vector;
   end Create;

end Path;
