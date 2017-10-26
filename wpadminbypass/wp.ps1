Add-Type @"
using System;
using System.Runtime.InteropServices;
using Microsoft.Win32;
namespace Wallpaper
{
   public class Setter {

      public const int SetDesktopWallpaper = 20;
      public const int UpdateIniFile = 0x01;
      public const int SendWinIniChange = 0x02;
      public const int COLOR_BACKGROUND = 1;

      [DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
      private static extern int SystemParametersInfo (int uAction, int uParam, string lpvParam, int fuWinIni);

      [DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
      private static extern int SetSysColors(int count, [In] ref int index, [In] ref int colour);

      public static void SetWallpaper ( string path) {
         RegistryKey key = Registry.CurrentUser.OpenSubKey("Control Panel\\Desktop", true);
         key.SetValue("WallpaperStyle", 0, RegistryValueKind.String);
         key.SetValue("TileWallpaper", 0, RegistryValueKind.String);
         key.Close();      
         SystemParametersInfo( SetDesktopWallpaper, 0, path, UpdateIniFile | SendWinIniChange );

         int index = COLOR_BACKGROUND;
         int colour = 0x212121;

         SetSysColors(1, ref index, ref colour);
      }
   }
}
"@

[Wallpaper.Setter]::SetWallpaper('C:\Users\gen01914\AppData\Roaming\Mozilla\Firefox\Desktop Background.bmp')
