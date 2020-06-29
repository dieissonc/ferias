Class	LVCores		{
   __New(HWND, StaticMode := False, NoSort := True, NoSizing := True) {
	  If (This.Base.Base.__Class) ; do not instantiate instances
		 Return False
	  If This.Attached[HWND] ; HWND is already attached
		 Return False
	  If !DllCall("IsWindow", "Ptr", HWND) ; invalid HWND
		 Return False
	  VarSetCapacity(Class, 512, 0)
	  DllCall("GetClassName", "Ptr", HWND, "Str", Class, "Int", 256)
	  If (Class <> "SysListView32") ; HWND doesn't belong to a ListView
		 Return False
	  ; ----------------------------------------------------------------------------------------------------------------
	  ; Set LVS_EX_DOUBLEBUFFER (0x010000) style to avoid drawing issues.
	  SendMessage, 0x1036, 0x010000, 0x010000, , % "ahk_id " . HWND ; LVM_SETEXTENDEDLISTVIEWSTYLE
	  ; Get the default colors
	  SendMessage, 0x1025, 0, 0, , % "ahk_id " . HWND ; LVM_GETTEXTBKCOLOR
	  This.BkClr := ErrorLevel
	  SendMessage, 0x1023, 0, 0, , % "ahk_id " . HWND ; LVM_GETTEXTCOLOR
	  This.TxClr := ErrorLevel
	  ; Get the header control
	  SendMessage, 0x101F, 0, 0, , % "ahk_id " . HWND ; LVM_GETHEADER
	  This.Header := ErrorLevel
	  ; Set other properties
	  This.HWND := HWND
	  This.IsStatic := !!StaticMode
	  This.AltCols := False
	  This.AltRows := False
	  This.NoSort(!!NoSort)
	  This.NoSizing(!!NoSizing)
	  This.OnMessage()
	  This.Critical := "Off"
	  This.Attached[HWND] := True
   }
   ; ===================================================================================================================
   On_WM_NOTIFY(W, L, M, H) {
	  Critical, % This.Critical
	  If ((HCTL := NumGet(L + 0, 0, "UPtr")) = This.HWND) || (HCTL = This.Header) {
		 Code := NumGet(L + (A_PtrSize * 2), 0, "Int")
		 If (Code = -12)
			Return This.NM_CUSTOMDRAW(This.HWND, L)
		 If !This.SortColumns && (Code = -108)
			Return 0
		 If !This.ResizeColumns && ((Code = -306) || (Code = -326))
			Return True
	  }
   }
   ; -------------------------------------------------------------------------------------------------------------------
   Row(Row, BkColor := "", TxColor := "") {
	  If !(This.HWND)
		 Return False
	  If This.IsStatic
		 Row := This.MapIndexToID(Row)
	  This["Rows"].Remove(Row, "")
	  If (BkColor = "") && (TxColor = "")
		 Return True
	  BkBGR := This.BGR(BkColor)
	  TxBGR := This.BGR(TxColor)
	  If (BkBGR = "") && (TxBGR = "")
		 Return False
	  This["Rows", Row, "B"] := (BkBGR <> "") ? BkBGR : This.BkClr
	  This["Rows", Row, "T"] := (TxBGR <> "") ? TxBGR : This.TxClr
	  Return True
   } 
 __Delete() {
	  This.Attached.Remove(HWND, "")
	  This.OnMessage(False)
	  WinSet, Redraw, , % "ahk_id " . This.HWND
   }
   Clear(AltRows := False, AltCols := False) {
	  If (AltCols)
		 This.AltCols := False
	  If (AltRows)
		 This.AltRows := False
	  This.Remove("Rows")
	  This.Remove("Cells")
	  Return True
   }
   AlternateRows(BkColor := "", TxColor := "") {
	  If !(This.HWND)
		 Return False
	  This.AltRows := False
	  If (BkColor = "") && (TxColor = "")
		 Return True
	  BkBGR := This.BGR(BkColor)
	  TxBGR := This.BGR(TxColor)
	  If (BkBGR = "") && (TxBGR = "")
		 Return False
	  This["ARB"] := (BkBGR <> "") ? BkBGR : This.BkClr
	  This["ART"] := (TxBGR <> "") ? TxBGR : This.TxClr
	  This.AltRows := True
	  Return True
   }
   AlternateCols(BkColor := "", TxColor := "") {
	  If !(This.HWND)
		 Return False
	  This.AltCols := False
	  If (BkColor = "") && (TxColor = "")
		 Return True
	  BkBGR := This.BGR(BkColor)
	  TxBGR := This.BGR(TxColor)
	  If (BkBGR = "") && (TxBGR = "")
		 Return False
	  This["ACB"] := (BkBGR <> "") ? BkBGR : This.BkClr
	  This["ACT"] := (TxBGR <> "") ? TxBGR : This.TxClr
	  This.AltCols := True
	  Return True
   }
   SelectionColors(BkColor := "", TxColor := "") {
	  If !(This.HWND)
		 Return False
	  This.SelColors := False
	  If (BkColor = "") && (TxColor = "")
		 Return True
	  BkBGR := This.BGR(BkColor)
	  TxBGR := This.BGR(TxColor)
	  If (BkBGR = "") && (TxBGR = "")
		 Return False
	  This["SELB"] := BkBGR
	  This["SELT"] := TxBGR
	  This.SelColors := True
	  Return True
   }

   Cell(Row, Col, BkColor := "", TxColor := "") {
	  If !(This.HWND)
		 Return False
	  If This.IsStatic
		 Row := This.MapIndexToID(Row)
	  This["Cells", Row].Remove(Col, "")
	  If (BkColor = "") && (TxColor = "")
		 Return True
	  BkBGR := This.BGR(BkColor)
	  TxBGR := This.BGR(TxColor)
	  If (BkBGR = "") && (TxBGR = "")
		 Return False
	  If (BkBGR <> "")
		 This["Cells", Row, Col, "B"] := BkBGR
	  If (TxBGR <> "")
		 This["Cells", Row, Col, "T"] := TxBGR
	  Return True
   }
   NoSort(Apply := True) {
	  If !(This.HWND)
		 Return False
	  If (Apply)
		 This.SortColumns := False
	  Else
		 This.SortColumns := True
	  Return True
   }
   NoSizing(Apply := True) {
	  Static OSVersion := DllCall("GetVersion", "UChar")
	  If !(This.Header)
		 Return False
	  If (Apply) {
		 If (OSVersion > 5)
			Control, Style, +0x0800, , % "ahk_id " . This.Header ; HDS_NOSIZING = 0x0800
		 This.ResizeColumns := False
	  }
	  Else {
		 If (OSVersion > 5)
			Control, Style, -0x0800, , % "ahk_id " . This.Header ; HDS_NOSIZING
		 This.ResizeColumns := True
	  }
	  Return True
   }
   OnMessage(Apply := True) {
	  If (Apply) && !This.HasKey("OnMessageFunc") {
		 This.OnMessageFunc := ObjBindMethod(This, "On_WM_Notify")
		 OnMessage(0x004E, This.OnMessageFunc) ; add the WM_NOTIFY message handler
	  }
	  Else If !(Apply) && This.HasKey("OnMessageFunc") {
		 OnMessage(0x004E, This.OnMessageFunc, 0) ; remove the WM_NOTIFY message handler
		 This.OnMessageFunc := ""
		 This.Remove("OnMessageFunc")
	  }
	  WinSet, Redraw, , % "ahk_id " . This.HWND
	  Return True
   }
   Static Attached := {}
   
   NM_CUSTOMDRAW(H, L) {
	  Static SizeNMHDR := A_PtrSize * 3                  ; Size of NMHDR structure
	  Static SizeNCD := SizeNMHDR + 16 + (A_PtrSize * 5) ; Size of NMCUSTOMDRAW structure
	  Static OffItem := SizeNMHDR + 16 + (A_PtrSize * 2) ; Offset of dwItemSpec (NMCUSTOMDRAW)
	  Static OffItemState := OffItem + A_PtrSize         ; Offset of uItemState  (NMCUSTOMDRAW)
	  Static OffCT :=  SizeNCD                           ; Offset of clrText (NMLVCUSTOMDRAW)
	  Static OffCB := OffCT + 4                          ; Offset of clrTextBk (NMLVCUSTOMDRAW)
	  Static OffSubItem := OffCB + 4                     ; Offset of iSubItem (NMLVCUSTOMDRAW)
	  ; ----------------------------------------------------------------------------------------------------------------
	  DrawStage := NumGet(L + SizeNMHDR, 0, "UInt")
	  , Row := NumGet(L + OffItem, "UPtr") + 1
	  , Col := NumGet(L + OffSubItem, "Int") + 1
	  , Item := Row - 1
	  If This.IsStatic
		 Row := This.MapIndexToID(Row)
	  ; CDDS_SUBITEMPREPAINT = 0x030001 --------------------------------------------------------------------------------
	  If (DrawStage = 0x030001) {
		 UseAltCol := !(Col & 1) && (This.AltCols)
		 , ColColors := This["Cells", Row, Col]
		 , ColB := (ColColors.B <> "") ? ColColors.B : UseAltCol ? This.ACB : This.RowB
		 , ColT := (ColColors.T <> "") ? ColColors.T : UseAltCol ? This.ACT : This.RowT
		 , NumPut(ColT, L + OffCT, "UInt"), NumPut(ColB, L + OffCB, "UInt")
		 Return (!This.AltCols && !This.HasKey(Row) && (Col > This["Cells", Row].MaxIndex())) ? 0x00 : 0x20
	  }
	  ; CDDS_ITEMPREPAINT = 0x010001 -----------------------------------------------------------------------------------
	  If (DrawStage = 0x010001) {
		 ; LVM_GETITEMSTATE = 0x102C, LVIS_SELECTED = 0x0002
		 If (This.SelColors) && DllCall("SendMessage", "Ptr", H, "UInt", 0x102C, "Ptr", Item, "Ptr", 0x0002, "UInt") {
			; Remove the CDIS_SELECTED (0x0001) and CDIS_FOCUS (0x0010) states from uItemState and set the colors.
			NumPut(NumGet(L + OffItemState, "UInt") & ~0x0011, L + OffItemState, "UInt")
			If (This.SELB <> "")
			   NumPut(This.SELB, L + OffCB, "UInt")
			If (This.SELT <> "")
			   NumPut(This.SELT, L + OffCT, "UInt")
			Return 0x02 ; CDRF_NEWFONT
		 }
		 UseAltRow := (Item & 1) && (This.AltRows)
		 , RowColors := This["Rows", Row]
		 , This.RowB := RowColors ? RowColors.B : UseAltRow ? This.ARB : This.BkClr
		 , This.RowT := RowColors ? RowColors.T : UseAltRow ? This.ART : This.TxClr
		 If (This.AltCols || This["Cells"].HasKey(Row))
			Return 0x20
		 NumPut(This.RowT, L + OffCT, "UInt"), NumPut(This.RowB, L + OffCB, "UInt")
		 Return 0x00
	  }
	  ; CDDS_PREPAINT = 0x000001 ---------------------------------------------------------------------------------------
	  Return (DrawStage = 0x000001) ? 0x20 : 0x00
   }
   ; -------------------------------------------------------------------------------------------------------------------
   MapIndexToID(Row) { ; provides the unique internal ID of the given row number
	  SendMessage, 0x10B4, % (Row - 1), 0, , % "ahk_id " . This.HWND ; LVM_MAPINDEXTOID
	  Return ErrorLevel
   }
   ; -------------------------------------------------------------------------------------------------------------------
   BGR(Color, Default := "") { ; converts colors to BGR
	  Static Integer := "Integer" ; v2
	  ; HTML Colors (BGR)
	  Static HTML := {AQUA: 0xFFFF00, BLACK: 0x000000, BLUE: 0xFF0000, FUCHSIA: 0xFF00FF, GRAY: 0x808080, GREEN: 0x008000
					, LIME: 0x00FF00, MAROON: 0x000080, NAVY: 0x800000, OLIVE: 0x008080, PURPLE: 0x800080, RED: 0x0000FF
					, SILVER: 0xC0C0C0, TEAL: 0x808000, WHITE: 0xFFFFFF, YELLOW: 0x00FFFF}
	  If Color Is Integer
		 Return ((Color >> 16) & 0xFF) | (Color & 0x00FF00) | ((Color & 0xFF) << 16)
	  Return (HTML.HasKey(Color) ? HTML[Color] : Default)
   }
}
Class	ColorPick	{
	byKey()	{
    static
	global	cpick
	cpick	=1
	loop,	21
		if(A_Index=21)
			Gui,	Add,	Picture,	x0	y0	vpallete%A_Index%	h*1	,	C:\Dguard Advanced\Color\%A_Index%.png
		else
			Gui,	Add,	Picture,	x0	y-1000	vpallete%A_Index%	h*1	,	C:\Dguard Advanced\Color\%A_Index%.png
	Gui,	Add,	Button,	xm	h20 gcpickGuiClose	,	Ok
	Gui,	Show,	,	CPallete
	return
	cpickGuiClose:
	cpick=0
	Gui,	Destroy
	return
   }
}
Class	Comandos	{	;	POR	FAZER
}
Class	Executa		{
	dguard()	{
		Run,	C:\Seventh\DGuardCenter\DGuard.exe			Run,					C:\Seventh\DGuardCenter\DGuard.exe
	}
	responsaveis()	{	
		Run,	C:\Dguard Advanced\Responsáveis.exe	
	}	
	email()				{	
		Run,	C:\Dguard Advanced\Agenda.exe	
	}	
	relatorios()			{	
		Run,	C:\Dguard Advanced\Relatórios.exe	
	}	
	colaboradores()	{	
		Run,	C:\Dguard Advanced\Colaboradores.exe	
	}	
	ramais()				{	
		Run,	C:\Dguard Advanced\Ramais.exe	
	}
}
Class	Finaliza		{
	dguard()	{
		Process,				Close,	WatchdogServices.exe
		Process,				Close,	Watchdog.exe
		Process,				Close,	DGuard.exe
		Process,				Close,	Player.exe
	}
}
Class	Servidor		{
	autoRestauro()	{
		server01	=	192.9.100.182
		server02	=	192.9.100.181
		soft = _class autoRestauro
		;~ server03	=	192.9.100.183
		Loop
		{
			s1 =
			s2 =
			Sleep,	1000
			RunWait,		%comspec% /c ipconfig /flushdns,,hide
			RunWait,		%comspec% /c for /f "skip=4 usebackq tokens=2" `%a in (``nslookup vdm01``) do echo `%a > %A_MyDocuments%\dns1.txt,,hide	;{
			FileRead,		s1a, %A_MyDocuments%\dns1.txt
			FileReadLine,	s1, %A_MyDocuments%\dns1.txt, 1
			FileDelete,		%A_MyDocuments%\dns1.txt
			s1	:=	StrReplace(s1,A_Space)
			s1x	:=	strReplace(s1,".")
			if	s1x	is	not	number
			{
				problema	=	s1x = %s1x%, não é um número, falha ao atualizar dns.
				Log(soft,A_LineNumber,problema)
				return
			}
			If(StrLen(s1)=0)
				s1	:=	server01	;}
			
			RunWait,		%comspec% /c for /f "skip=4 usebackq tokens=2" `%a in (``nslookup vdm02``) do echo `%a > %A_MyDocuments%\dns2.txt,,hide	;{
			FileRead,		s2a, %A_MyDocuments%\dns2.txt
			FileReadLine,	s2, %A_MyDocuments%\dns2.txt, 1
			FileDelete,		%A_MyDocuments%\dns2.txt
			s2	:=	StrReplace(s2,A_Space)
			s2x	:=	strReplace(s2,".")
			if	s2x	is	not	number
			{
				problema	=	s2x = %s2x%, não é um número, falha ao atualizar dns.
				Log(soft,A_LineNumber,problema)
				return
			}
			If(StrLen(s2)=0)
				s2	:=	server02	;}
			
			;~ RunWait,		%comspec% /c for /f "skip=4 usebackq tokens=2" `%a in (``nslookup vdm03``) do echo `%a > %A_MyDocuments%\dns3.txt,,hide	;{
			;~ FileRead,		s3a, %A_MyDocuments%\dns3.txt
			;~ FileReadLine,	s3, %A_MyDocuments%\dns3.txt, 1
			;~ FileDelete,		%A_MyDocuments%\dns3.txt
			;~ s3	:=	StrReplace(s3,A_Space)
			;~ s3x	:=	strReplace(s3,".")
			;~ if	s3x	is	not	number
			;~ {
				;~ problema	=	s3x = %s3x%, não é um número, falha ao atualizar dns.
				;~ Log(soft,A_LineNumber,problema)
				;~ return
			;~ }
			;~ If(StrLen(s3)=0)
				;~ s3	:=	server03	;}
			if(A_Index=1)	{	;	Caso o sistema seja rodado após a redundância estar ativada, prepara o sistema
				if			(s1="192.9.100.187")	{
					server01	=	192.9.100.187
					troca	=	1
				}
				else	if	(s2="192.9.100.187")	{
					server02	=	192.9.100.187
					troca	=	1
				}
				else	if	(s3="192.9.100.187")	{
					server03	=	192.9.100.187
					troca	=	1
				}
				else
					troca	=	0
			}

			if(s1!=server01)	{
				troca :=	!troca
				if(troca=1)
					server01	=	192.9.100.187
				else
					server01	=	192.9.100.182
			}
			if(s2!=server02)	{
				troca :=	!troca
				if(troca=1)
					server02	=	192.9.100.187
				else
					server02	=	192.9.100.181
			}
			;~ if(s3!=server03)	{
				;~ troca :=	!troca
				;~ if(troca=1)
					;~ server03	=	192.9.100.187
				;~ else
					;~ server03	=	192.9.100.183
			;~ }
		}
	}
}
Class	Arquivos		{	;	POR	FAZER
	copiar()	{
		FileCopy,		%smk%update.exe,					C:\Seventh\backup\update.exe,				1	
		if	(	ip4	=	162	or	ip4	=	166	or	ip4	=	169	or	ip4	=	176	or	ip4	=	179	or	ip4	=	184	)	{	
			FileCopy,		%smk%map\*.jpg,				C:\Seventh\backup\map,							1	
			IfNotExist,		C:\Dguard Advanced\Agenda_user.exe	
			{	
				Process,		Close,	Agenda_user.exe	
				FileCopy,	%smk%Agenda_user.exe,				C:\Dguard Advanced\Agenda_user.exe,		1	
			}	
			IfNotExist,		C:\Dguard Advanced\Notificações.exe	
			{	
				Process,		Close,	Notificações.exe	
				FileCopy,	%smk%Notificações.exe,				C:\Dguard Advanced\Notificações.exe,				1	
			}	
			IfNotExist,		C:\Dguard Advanced\Colaboradores.exe				
			{	
				Process,		Close,	Colaboradores.exe	
				FileCopy,	%smk%Colaboradores.exe,			C:\Dguard Advanced\Colaboradores.exe,				1	
			}	
			IfNotExist,		C:\Dguard Advanced\Detecção.exe				
			{	
				Process,		Close,	Detecção.exe	
				FileCopy,	%smk%Detecção.exe,						C:\Dguard Advanced\Detecção.exe,				1	
			}	
			IfNotExist,		C:\Dguard Advanced\MDRam.exe				
			{	
				Process,		Close,	MDRam.exe	
				FileCopy,	%smk%MDRam.exe,						C:\Dguard Advanced\MDRam.exe,				1	
			}	
			IfNotExist,		C:\Dguard Advanced\Relatórios.exe				
			{	
				Process,		Close,	Relatórios.exe	
				FileCopy,	%smk%Relatórios.exe,			C:\Dguard Advanced\Relatórios.exe,	1	
			}	
			if	(	ip4	=	184	or A_UserName = "Alberto")																{	
				FileCopy,	%smk%AutAdd.exe,			C:\Dguard Advanced\AutAdd.exe,			1	
				FileCopy,	%smk%AutRem.exe,			C:\Dguard Advanced\AutRem.exe,			1	
				FileCopy,	%smk%RespAdd.exe,		C:\Dguard Advanced\RespAdd.exe,		1	
				FileCopy,	%smk%RespDel.exe,			C:\Dguard Advanced\RespDel.exe,			1	
				FileCopy,	%smk%LembEdit.exe,		C:\Dguard Advanced\LembEdit.exe,		1	
			}	
		}	
	}
	deletar()	{
	}
}