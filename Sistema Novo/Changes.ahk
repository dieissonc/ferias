a1=0
a2=0
a3=0
a4=0

Gui, 1:Color,, Green
Gui, 1:Font, CBlue
Gui, 1:Add, Edit, vMyEdit w200 h100, The quick onyx goblin`njumps over the lazy dwarf
Gui, 1:Add, Button, gMyButton1 w200 h40, Change text color
Gui, 1:Add, Button, gMyButton2 w200 h40, Change background color
Gui, 1:Add, Button, gMyButton3 w200 h40, Change text alignment
Gui, 1:Add, Button, gMyButton4 w200 h40, Change text size
Gui,	1:Add, Slider,	 gMyButton4	w200 h40  vFontSize	Range8-16	TickInterval1	ToolTipRight ,	12
Gui, 1:Show,, My GUI
return

MyButton1:
if(a1=0)	{
Gui, Font, cYellow
GuiControl, Font, MyEdit
a1 = 1
return
}	else	{
Gui, Font, cBlue
GuiControl, Font, MyEdit
a1 = 0
return
}

MyButton2:
if(a2=0)	{
Gui, Color,, Red
a2 = 1
return
}	else	{
Gui, Color,, Green
a2 = 0
return
}

MyButton3:
if(a3=0)	{
GuiControl, +Center, MyEdit
a3 = 1
return
}
if(a3=1)	{
GuiControl, +Right, MyEdit
a3 = 2
return
}
if(a3=2)	{
GuiControl, +Left, MyEdit
a3 = 0
return
}

MyButton4:
Gui, 1:Font, s%FontSize%
GuiControl, 1:Font, MyEdit
return
Esc::
GuiClose:
ExitApp