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

package Draw is

   procedure Text
     (W    : sfWindow_Ptr; T : sfText_Ptr; F : sfFont_Ptr; Str : String;
      Size : sfUint32; Color : sf.Graphics.Color.sfColor; Pos : sfVector2f);

end Draw;
