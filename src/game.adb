with Ada.Command_Line; use Ada.Command_Line;
with Ada.Text_IO;      use Ada.Text_IO;
with Ada.Directories;  use Ada.Directories;
-- with Ada.Strings.Fixed; use Ada.Strings.Fixed;

with Sf.Window.VideoMode;
use Sf, Sf.Window, Sf.Window.VideoMode;
with Sf.Window.Event;  use Sf.Window.Event;
with Sf.Window.Window; use Sf.Window.Window;

with Sf.Graphics.Color;
use Sf.Graphics, Sf.Graphics.Color;
with Sf.Graphics.RenderWindow; use Sf.Graphics.RenderWindow;
with Sf.Graphics.Sprite;       use Sf.Graphics.Sprite;
with Sf.Graphics.Texture;      use Sf.Graphics.Texture;
with Sf.Graphics.Font;         use Sf.Graphics.Font;
with Sf.Graphics.Text;         use Sf.Graphics.Text;

with Sf.Audio.Music;
use Sf.Audio, Sf.Audio.Music;

with Ada.Numerics.Real_Arrays; use Ada.Numerics.Real_Arrays;
with Isometric;                use Isometric;
with Line;
with Ship;

with Sf.Graphics.VertexArray;   use Sf.Graphics.VertexArray;
with Sf.Graphics.PrimitiveType; use Sf.Graphics.PrimitiveType;
with Sf.Graphics.View;          use Sf.Graphics.View;

procedure Game is

   Abort_Example : exception;

   Mode : VideoMode.sfVideoMode :=
     (width => 800, height => 600, bitsPerPixel => 32);
   Window  : sfRenderWindow_Ptr;
   Texture : sfTexture_Ptr;
   Sprite  : sfSprite_Ptr;
   Font    : sfFont_Ptr;
   Text    : sfText_Ptr;
   Music   : sfMusic_Ptr;
   event   : sfEvent;
   View    : sfView_Ptr;

   ExeDir : constant String := Containing_Directory (Command_Name);

   Vertex_Arr : sfVertexArray_Ptr;
   X          : Real_Vector := (200.0, 300.0);
   Y          : Real_Vector := (140.0, 200.0);
   L          : array (0 .. 1) of Real_Vector (0 .. 1);
   WL         : Line.World_Line (0 .. 2);
   SL         : Line.Screen_Line (0 .. 2);
   SV         : Line.Screen_Vertices (0 .. 2);
   Ship_1     : Ship.Ship;
   Ship_Name  : String      := "012345";
begin

   WL              := ((0.0, 0.0), (4.0, 0.0), (4.0, 1.0));
   SL              := Line.World_To_Screen (WL);
   Vertex_Arr      := Line.Line_To_Vertex_Arr_Ptr (SL);
   Ship_1          := Ship.Spawn ((0.0, -20.0), Ship.Small, Ship_Name);
   Ship_1.Waypoint := (0.0, 40.0);

   -- Create the main Window
   Window :=
     create
       (Mode, "SFML window", sfResize or sfClose, sfDefaultContextSettings);
   setFramerateLimit (Window, 60);

   View := create;
   setSize (View, (800.0, 600.0));
   setCenter (View, (0.0, 0.0));

   setView (Window, View);

   -- Load a sprite to display
   Texture := createFromFile (ExeDir & "/avatar.png", null);

   Sprite := create;
   setTexture (Sprite, Texture, sfTrue);

   -- Create a graphical text to display
   Font := createFromFile (ExeDir & "/Roboto-Regular.ttf");

   Text := create;
   setString (Text, "ao");
   setFont (Text, Font);
   setCharacterSize (Text, 50);
   setPosition (Text, (0.0, 0.0));

   -- -- Load a music file to play
   -- Music := createFromFile("nice_music.ogg");

   -- -- Play the music
   -- play(Music);

   -- Start the game loop
   while isOpen (Window) loop

      -- Process events
      while pollEvent (Window, event) loop

         -- Close window : exit
         if event.eventType = sfEvtClosed then
            close (Window);
         end if;
      end loop;

      -- Clear the screen
      clear (Window, sfBlack);

      -- Draw the sprite
      -- drawSprite (Window, Sprite, null);

      drawVertexArray (Window, Vertex_Arr, null);
      Ship.Update (Ship_1);
      Ship.Draw (Window, Ship_1, Font);

      -- -- Draw the text
      drawText (Window, Text, null);

      -- Update the window
      display (Window);
   end loop;

   -- Cleanup resources
   destroy (Music);
   destroy (Text);
   destroy (Font);
   destroy (Sprite);
   destroy (Texture);
   destroy (Window);

   destroy (Vertex_Arr); -- path
   Ship.Destroy (Ship_1);

exception
   when others =>

      Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);

end Game;
