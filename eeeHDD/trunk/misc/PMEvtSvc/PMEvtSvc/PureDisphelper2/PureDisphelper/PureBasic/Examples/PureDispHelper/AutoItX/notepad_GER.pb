﻿
XIncludeFile "Register_Unregister_ActiveX.pb"

EnableExplicit

Define.l oAU3, Result

oAU3 = dhCreateObject("AutoItX3.Control")

If oAU3 = #False
  If RegisterActiveX("AutoItX3.dll")
    oAU3 = dhCreateObject("AutoItX3.Control")
  EndIf
EndIf

If oAU3
  MessageRequester("AutoItX3", "Dieses Skript startet Notepad und fügt 2 Zeilen ein")
  dhToggleExceptions(#True)
  dhGetValue("%d", @Result, oAU3, "Run(%T,%T,%d", @"notepad.exe", @"", #SW_SHOWNORMAL)
  dhGetValue("%d", @Result, oAU3, "WinWaitActive(%T,%T,%d",@"Unbenannt - Editor", @"", 5)
  If Result
    dhGetValue("%b", @Result, oAU3, "Send(%T)",@"Hallo, dies ist die erste Zeile{ENTER}")
    dhGetValue("%b", @Result, oAU3, "Send(%T)",@"Hallo, dies ist die zweite Zeile{ENTER}")
    dhCallMethod(oAU3, "Sleep = %d", 1000)
    dhGetValue("%b", @Result, oAU3, "Send(%T)",@"!{F4}")
    dhGetValue("%b", @Result, oAU3, "WinWaitActive(%T,,%T,%d)", @"Editor", @"Aktuelle Änderungen speichern?", 5)
    If Result
      dhGetValue("%b", @Result, oAU3, "Send(%T)",@"!n")
      dhGetValue("%b", @Result, oAU3, "WinClose(%T,%T)", @"Unbenannt - Editor", @"")
    EndIf
  EndIf
  dhReleaseObject(oAU3)
EndIf

; IDE Options = PureBasic v4.02 (Windows - x86)
; CursorPosition = 28
; Folding = -
; EnableXP
; HideErrorLog