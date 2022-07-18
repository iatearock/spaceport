package body Draw is

   -- Draw Text, apply other setting to T prior to this procedure to apply additional settings
   procedure Text
     (W    : sfWindow_Ptr; T : sfText_Ptr; F : sfFont_Ptr; Str : String;
      Size : sfUint32; Color : sf.Graphics.Color.sfColor; Pos : sfVector2f)
   is
   begin
      setString (T, Str);
      setFont (T, F);
      setCharacterSize (T, Size);
      setPosition (T, Pos);

      drawText (W, T);

   end Text;

end Draw;
