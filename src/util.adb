package body Util is

   function SfBool_To_Boolean (B : sfBool) return Boolean is
      NB : Boolean;
   begin
      if B = sfTrue then
         NB := True;
      else
         NB := False;
      end if;
      return NB;
   end SfBool_To_Boolean;

   procedure Toggle_Boolean (B : in out Boolean) is
   begin
      if B = True then
         B := False;
      else
         B := True;
      end if;
   end Toggle_Boolean;

end Util;
