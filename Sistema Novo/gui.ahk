debugando=
#Include ..\Libs\_.ahk	;{
		ImageListID := IL_Create(2)
		IL_Add(ImageListID, "C:\Users\dsantos\Desktop\AHK\img\senha.png")
		IL_Add(ImageListID, "C:\Users\dsantos\Desktop\AHK\img\ssenha.png")
		Gui,	1:Color,	544D4F
		Gui,	1:Color,	,	B3BAB3
		lemon	=	0x719971
		green	=	0x636E63
		red		=	0xAD2E24
		SysGet,	o,	MonitorWorkArea	;	Altura - taskbar size
		SysGet,	t,	31							;	Title bar Size	;}
;{					GUI
;{'	HEADERS
		Gui,	1:Font,	S15	Bold	c%lemon%	
Gui,	1:Add, Text,			x320	y10			w930					Center	0x1000						vUnidadeNome																						,	Nome da Unidade
Gui,	1:Add, Text,			x10		y150		w410					Center	0x1000																																		,	Responsáveis
Gui,	1:Add, Text,			x10		y350		w410					Center	0x1000					vTAut								g_Autorizados													,	+ Autorizados
Gui,	1:Add, Text,			x425	y685		w825					Center	0x1000					vTCol								g_Colaboradores												,	+ Colaboradores
Gui,	1:Add, Text,			x425	y200		w825					Center	0x1000																																		,	20 Últimos E-Mails
		Gui,	1:Font	;}
;{	Edit box
		Gui,	1:Font,	S10
Gui,	1:Add, Edit,		x10		y10			w300		h20														vBuscaUnidade				gAUnidades
Gui,	1:Add, Edit,		x650	y228		w600		h25														vBuscaEmail					g2ListaEmails
		Gui,	1:Font	;}
;{	Listviews
		Gui,	1:Font,	S10 cWhite
Gui,	1:Add, ListView,	x10		y35			w300		R5					-HDR		Grid		Sort	vLVUnidades					g1SelecionaUnidade	AltSubmit	hwndHL1,	Unidades|ID|idg|idc|setores|id_camera|id_mail|cd_estabs
Gui,	1:Add, ListView,	x10		y175		w410		R7					-HDR		Grid				vLVResponsaveis																	hwndHL2,	Nome|Cargo|Matrícula|Ramal|Telefone 1|Telefone 2|Situação|Local|Sexo
Gui,	1:Add, ListView,	x10		y375		w410		R6									Grid				vLVAutorizados				Hidden											hwndHL5,	Nome|Matrícula|Senha|Ok	;{
		LV_SetImageList(ImageListID)
		LV_ModifyCol(1,300)
		LV_ModifyCol(2,85)
		LV_ModifyCol(2,"Integer")
		LV_ModifyCol(3,0)
		LV_ModifyCol(4,0)	;}
Gui,	1:Add, ListView,	x425	y710		w825		R6					-HDR		Grid				vLVColaboradores			Hidden											hwndHL4,	Colaborador|Ramal|Cargo|Setor|Telefone 1|Telefone 2|Sexo	;{
		LV_ModifyCol(1,249)
		LV_ModifyCol(2,70)
		LV_ModifyCol(3,275)
		LV_ModifyCol(4,210)
		LV_ModifyCol(5,0)
		LV_ModifyCol(6,0)
		LV_ModifyCol(7,0)	;}
Gui,	1:Add, ListView,	x425	y255		w825		R3					-HDR		Grid				vLVEmails						g3ExibeEmail				AltSubmit	hwndHL3,	Data|Mensagem	;{
		LV_ModifyCol(1,130)
		LV_ModifyCol(2,670)	;}	;}
;{	Edibox - EMAIL
		Gui,	1:Font
		Gui,	1:Font,	S12
Gui,	1:Add, Edit,		x425	y320		w825		h340													vEmails
		Gui,	1:Font,	cWhite	;}
;{	Textos
Gui,	1:Add, Text,			x425	y229		w225		h24		Right	0x1000																																		,	E-Mails contendo  :  
Gui,	1:Add, Text,			x320	y50			w930		h90					0x1000						vEnderecoUnidade																				,	Endereço	;}
;{	TAB
		Gui,	1:Font,	cWhite
Gui,	1:Add, Tab3,		x425	y150		w825		h25														vTabMapas						gMapas	;}

if(debugando!=1)
Loop,	5
	if(A_Index=5)
		cor%A_index% := New LVCores(HL%A_Index%, True, false)
	else
		cor%A_index% := New LVCores(HL%A_Index%, false, false)
gosub	AUnidades
gosub	AColunaTamanhos
altura	:=	oBottom-oTop
Gui,	1:Show,	%			"x-1		y0			w" A_screenWidth	"	h"	altura-t,	Sistema Monitoramento
return	;}

AColunaTamanhos:		;{
	Gui,	1:ListView,	LVUnidades
	LV_ModifyCol()
	Loop, 8
		LV_ModifyCol(A_Index+1,0)
	LV_ModifyCol(1,275)
	Gui,	1:ListView,	LVResponsaveis
	LV_ModifyCol()
	Loop, 9
		LV_ModifyCol(A_Index+1,0)
	LV_ModifyCol(2,150)
	LV_ModifyCol(1,250)
	return	;}
Aunidades:					;{	Preenche, Filtra e configura a listview de unidades
	Gui,	1:ListView,	LVUnidades
	Gui,	1:Submit, NoHide
	s=SELECT nm_unidade, id_unidade, id_gerencia, id_cotrijal, Setores, id_cameras, id_mail, cds_estabs FROM asm.asm.dbo.dados_unidades WHERE nm_unidade LIKE '`%%BuscaUnidade%`%'
	r:=ADOSQL(con,s)
	LV_Delete()
	Loop, % r.MaxIndex()-1
	{
		if((((A_Index & 1) != 0) ? "1" : "2")=2)
			cor1.Row(A_Index, lemon)
		else
			cor1.Row(A_Index, green)
		LV_Add("", r[A_Index+1,1], r[A_Index+1,2], r[A_Index+1,3], r[A_Index+1,4], r[A_Index+1,5], r[A_Index+1,6], r[A_Index+1,7], r[A_Index+1,8])
	}
	return	;}

1SelecionaUnidade:	;{
	if((A_GuiEvent="K" or A_GuiEvent="Normal") and A_GuiControl="LVUnidades")	{
		Gui,	2:Destroy
		Gui,	1:ListView,	LVUnidades
		Gui,	1:Submit,	NoHide
		Loop,	8																																										;{	Carrega os dados da unidade para fazer a busca de responsáveis e 4Colaboradores
		{
			if(A_GuiEvent="K"	AND (A_EventInfo = 40	or	A_EventInfo = 38))
				LV_GetText(dados%A_Index%,lv_getnext(),A_Index)
			else
				LV_GetText(dados%A_Index%,A_eventInfo,A_Index)
		}	;}
		if(dados1="Unidades" or idUnidade=dados2)	;{	Evita rodar o loop em casos desnecessários
			return	;}
		Gui, 1: +Disabled
		autoselect=1
		ramalselect=1
		Gui,	1:Listview,	LVEmails
		LV_Delete()
		GuiControl,	1:,	Emails
		Gui,	1:ListView,	LVUnidades
		cdestabs	:= dados8
		idmail	:= dados7
		idUnidade:=dados2
		idlocal:=dados3
		idorg:=dados4
		gosub	TabDeMapas
		Gui,	1:ListView,	LVResponsaveis
		s=																;{	Seleciona os 4Colaboradores da unidade
		(
			SELECT
							dn_local,	dn_cargo,	nm_razao_social,	cd_func,	ramal,	celular,	fone,	(SELECT DESSIT FROM SENIOR.R010SIT WHERE CODSIT=situacao), cd_cargo, sexo
			FROM		cad_funcionarios
			WHERE	cd_cargo IN ('0288.00','0378.01','0378.03','0334.01','0373.00','0374.00','0294.00','0251.00','0383.00') AND situacao <> 7
			AND		(cd_setor Like '%dados3%`%'	OR cd_local_org Like '%dados4%`%')
			ORDER BY	9 DESC
		)
		r:=adosql(ora,s)
		LV_Delete()	;}
		Loop,	%	r.MaxIndex()-1							;{	Adiciona responsáveis na lista
		{
			if(InStr(MaskCargo(r[A_Index+1,2]),"adm")>0)	{
				if(InStr(dados5,"A")>0)
					1adm	.= A_Index 
				else
					continue
			}
			if(InStr(MaskCargo(r[A_Index+1,2]),"oper")>0)	{
				if(InStr(dados5,"B")>0)
					1oper	.= A_Index 
				else
					continue
			}
			if(InStr(MaskCargo(r[A_Index+1,2]),"loja")>0)		{
				if(InStr(dados5,"L")>0)
					1loja	.= A_Index 
				else
					continue
			}
			if(InStr(MaskCargo(r[A_Index+1,2]),"sup")>0)		{
				if(InStr(dados5,"S")>0)
					1sup	.= A_Index 
				else
					continue
			}
			LV_Add("", MaskName(r[A_Index+1,3]),MaskCargo(r[A_Index+1,2]), r[A_Index+1,4], r[A_Index+1,5], r[A_Index+1,6], r[A_Index+1,7], r[A_Index+1,8], r[A_Index+1,1], r[A_Index+1,10])
		}	;}
																			;{	trata mais de um coordenador na unidade
		if(strlen(1adm)=2)	{
			linha1	:=	SubStr(1adm,1,1)
			linha2	:=	SubStr(1adm,2,1)
		}
		if(strlen(1loja)=2)	{
			linha1	:=	SubStr(1loja,1,1)
			linha2	:=	SubStr(1loja,2,1)
		}
		if(strlen(1oper)=2)	{
			linha1	:=	SubStr(1oper,1,1)
			linha2	:=	SubStr(1oper,2,1)
		}
		if(strlen(1sup)=2)	{
			linha1	:=	SubStr(1sup,1,1)
			linha2	:=	SubStr(1sup,2,1)
		}
		LV_GetText(duplicado,linha1,8)
		if(duplicado=dados1)
			LV_Delete(linha2)
		else
			LV_Delete(linha1)	;}
																			;{	Limpa as variáveis
		linha1=
		linha2=
		1adm=
		1loja=
		1sup=
		1oper=	;}
		Loop,	%	r.MaxIndex()-1							;{	Cores  da LV
		{
			if((((A_Index & 1) != 0) ? "1" : "2")=2)
				cor2.Row(A_Index, lemon)
			else
				cor2.Row(A_Index, green)
		}	;}
		GuiControl,	,	UnidadeNome,	%	dados1 " - " idUnidade
		gosub	2ListaEmails
	}
	return	;}

2ListaEmails:				;{
	Gui,	1:Submit,	NoHide
	Gui,	1:Listview,	LVEmails
	LV_Delete()
	if(strlen(idmail)=1)
		idmail	:=	"00" idmail
	if(strlen(idmail)=2)
		idmail	:=	"0" idmail
	filtra_email	=
	if(strlen(BuscaEmail)>0)	{
		GuiControl,	1:,	Emails
		Loop
		{
			busca_antiga	:=	LVEmails
			Sleep,	250
			Gui,	1:Submit,	NoHide
			if(BuscaEmail!=busca_antiga)	{
				filtro=1
				break
			}
		}
		filtra_email	=	AND p.Mensagem LIKE '`%%BuscaEmail%`%'
	}
	mail =
	(
		SELECT top (20) p.IdCliente, p.QuandoGerou, p.Mensagem, p.Assunto, c.Nome,	p.Idaviso
		FROM [IrisSQL].[dbo].[Agenda] p
		LEFT JOIN [IrisSQL].[dbo].[Clientes] c ON p.IdCliente = c.IdUnico
		WHERE c.Particao = '%idmail%'
		%filtra_email%
		ORDER BY 6 DESC
	)
	mail	:=	adosql(con,mail)
	Loop, % mail.MaxIndex()-1
	{
		data	:=	mail[A_Index+1,2]
		msg		:=	mail[A_Index+1,3]
		LV_Add("",data,msg)
		if((((A_Index & 1) != 0) ? "1" : "2")=2)
			cor3.Row(A_Index, Green)
		else
			cor3.Row(A_Index, Lemon)
	}
	gosub	3ExibeEmail
	return	;}
3ExibeEmail:				;{
	if(A_GuiEvent="K"	or	A_GuiEvent="Normal")	{
	Gui,	1:Submit,	NoHide
	Gui,	1:ListView,	LVEmails
	if(A_GuiEvent="K"	AND (A_EventInfo = 40	or	A_EventInfo = 38))	;{
		LV_GetText(mensagem,lv_getnext(),2)
	else
		LV_GetText(mensagem,A_EventInfo,2)	;}
	if(autoselect=1)	{
		LV_GetText(mensagem,1,2)
		autoselect=0
	}
	if(filtro=1)	{
		LV_GetText(mensagem,1,2)
		if(mensagem="mensagem")	;{	Evita rodar o loop em casos desnecessários
			return	;}
		GuiControl,	1:,	Emails,	%	mensagem
		filtro=0
	}
	if(mensagem="mensagem")	;{	Evita rodar o loop em casos desnecessários
		return	;}
	GuiControl,	1:,	Emails,	%	mensagem
	GuiControl,	1:Focus,	LVUnidades
}
if(ramalselect=1)	{
	gosub	4Colaboradores
	ramalselect=0
}
return	;}
4Colaboradores:			;{
Gui,	1:ListView,	LVColaboradores
	LV_Delete()
	id_unidade	=	AND (cd_local = '%idlocal%')
	ramais	=	SELECT nm_razao_social, ramal, dn_cargo, dn_setor, celular, fone, sexo FROM cad_funcionarios WHERE (length(TRIM(ramal)) > '3' and situacao not in (7,33)) %id_unidade% ORDER BY 1, 2
	ramais	:=	adosql(ora,ramais)
	Gui,	1:ListView,	LVColaboradores
	Loop, % ramais.MaxIndex()-1
	{
		nome:=ramais[A_Index+1,1]
		cargo:=StrReplace(StrReplace(StrReplace(StrReplace(StrReplace(StrReplace(StrReplace(StrReplace(StrReplace(ramais[A_Index+1,3],"Auxiliar","Aux."),"Coordenador","Coor.")," De Unidade De Negocios")," Unidade")," Atendimento Produtor")," Armazens")," iiI") ," ii")," i")
		StringUpper,	nome,	nome,	T
		StringUpper,	cargo,	cargo,	T
		LV_Add("", nome, ramais[A_Index+1,2], cargo, ramais[A_Index+1,4],ramais[A_Index+1,5],ramais[A_Index+1,6],ramais[A_Index+1,7])
		if(debugando!=1)	;{
			if((((A_Index & 1) != 0) ? "1" : "2")=2)
				cor4.Row(A_Index, Green)
			else
				cor4.Row(A_Index, Lemon)	;}
	}
	gosub	5Autorizados
return	;}
5Autorizados:				;{
Gui,	1:ListView,	LVAutorizados
LV_Delete()
sAutorizados=SELECT matricula, senha, id_unidade FROM [ASM].[asm].[dbo].[autorizados_unidades] WHERE id_unidade = '%idUnidade%'
sAutorizados:=adosql(con,sAutorizados)
Loop,	%	sAutorizados.maxIndex()-1
	if(A_Index!=sAutorizados.maxIndex()-1)
		in	.=	sAutorizados[A_Index+1, 1] ","
	else
		in	.=	sAutorizados[A_Index+1, 1]
sNomesAutorizados=SELECT nm_razao_social, numcad, cd_local, cd_estab FROM cad_funcionarios WHERE numcad IN (%in%)
nomesAutorizados:=adosql(ora,sNomesAutorizados)

Loop,	%	sAutorizados.maxIndex()-1
{
	matricula:=sAutorizados[A_Index+1,1]
	senha:=sAutorizados[A_Index+1,2]
	Loop,	%	nomesAutorizados.MaxIndex()-1
	{
		if(matricula=nomesAutorizados[A_Index+1,2])	{
			if(idlocal!=nomesAutorizados[A_Index+1,3])	{
				LocalAtual	:=	nomesAutorizados[A_Index+1,3]
				cd_estab		:=	Floor(nomesAutorizados[A_Index+1,4])
			}
			nome:=MaskName(nomesAutorizados[A_Index+1,1])
			continue
		}
		if(StrLen(LocalAtual)>0	and InStr(cdestabs,cd_estab)=0)
			ok = 0
		else
			ok = 1
	}
	if(StrLen(senha)=0)	{
		LV_Add("Icon2", nome, matricula, senha, ok)
	}	else	{
		LV_Add("Icon1", nome, matricula, senha, ok)
	}
	LocalAtual=
}
; static color
Loop,	%	LV_GetCount()
{
	LV_GetText(ok,A_Index,4)
	if((((A_Index & 1) != 0) ? "1" : "2")=2)
		cor5.Row(A_Index, Green)
	else
		cor5.Row(A_Index, Lemon)
	if(ok=0)	{
		cor5.Row(A_Index, Red)
	}
}
LV_ModifyCol(2,"Sort")
Gui, 1: -Disabled
return	;}
GuiContextMenu()		{
		if(menufeito>0)
			Menu, docall, DeleteAll
		if (A_GuiControl = "LVResponsaveis")	{	;	or	WinExist(mapaon))	{  ; This check is optional. It displays the menu only for clicks inside the ListView.
			Gui,	ListView,	%	A_GuiControl
			menufeito++
			ramal=
			tel1=
			tel2=
			LV_GetText(quem,A_eventinfo,1)
			LV_GetText(ramal,A_eventinfo,4)
			LV_GetText(tel1,A_eventinfo,5)
			LV_GetText(tel2,A_eventinfo,6)
			LV_GetText(sex,A_eventinfo,9)
			tel1:=Masktel(tel1)
			tel2:=Masktel(tel2)
			Menu,	docall,	Add,	%	quem,	Ligar
			Menu,	docall,	Add
			Menu,	docall,	Add,	Ligar para %ramal%,	Ligar
			Menu,	docall,	Add,	Ligar para %tel1%,	Ligar
			if(tel1!=tel2)	{
				Menu,	docall,	Add,	Ligar para %tel2%,	Ligar
				Menu,	docall,	Icon,	Ligar para %tel2%,	..\img\phone.png,, 0
			}
			Menu,	docall,	Color,	C9FFF8
			if(sex="M")
				Menu,	docall,	Icon,	%	quem					,	..\img\bman.png,, 0
			else
				Menu,	docall,	Icon,	%	quem					,	..\img\bwoman.png,, 0
			Menu,	docall,	Icon,	Ligar para %ramal%	,	..\img\phone.png,, 0
			Menu,	docall,	Icon,	Ligar para %tel1%		,	..\img\phone.png,, 0
			Menu, docall, Default,	%	quem
			Menu, docall, Show, %A_GuiX%, %A_GuiY%,	mapaon
		}
		if (A_GuiControl = "LVColaboradores")	{	;	or	WinExist(mapaon))	{  ; This check is optional. It displays the menu only for clicks inside the ListView.
			Gui,	ListView,	%	A_GuiControl
			menufeito++
			ramal=
			tel1=
			tel2=
			LV_GetText(quem,A_eventinfo,1)
			LV_GetText(ramal,A_eventinfo,2)
			LV_GetText(tel1,A_eventinfo,5)
			LV_GetText(tel2,A_eventinfo,6)
			LV_GetText(sex,A_eventinfo,7)
			tel1:=Masktel(tel1)
			tel2:=Masktel(tel2)
			Menu,	docall,	Add,	%	quem,	Ligar
			Menu,	docall,	Add
			Menu,	docall,	Add,	Ligar para %ramal%,	Ligar
			Menu,	docall,	Add,	Ligar para %tel1%,	Ligar
			if(tel1!=tel2)	{
				Menu,	docall,	Add,	Ligar para %tel2%,	Ligar
				Menu,	docall,	Icon,	Ligar para %tel2%,	..\img\phone.png,, 0
			}
			Menu,	docall,	Color,	C9FFF8
			if(sex="M")
				Menu,	docall,	Icon,	%	quem					,	..\img\bman.png,, 0
			else
				Menu,	docall,	Icon,	%	quem					,	..\img\bwoman.png,, 0
			Menu,	docall,	Icon,	Ligar para %ramal%	,	..\img\phone.png,, 0
			Menu,	docall,	Icon,	Ligar para %tel1%		,	..\img\phone.png,, 0
			Menu, docall, Default,	%	quem
			Menu, docall, Show, %A_GuiX%, %A_GuiY%,	mapaon
		}
	}
Ligar:							;{
	if(A_ThisMenuItemPos=1)
		return
	if(InStr(A_IpAddress1,"184")>0)
		ramal=2524
	if(InStr(A_IpAddress1,"162")>0)
		ramal=2530
	if(InStr(A_IpAddress1,"166")>0)
		ramal=2852
	if(InStr(A_IpAddress1,"169")>0)
		ramal=2853
	if(InStr(A_IpAddress1,"176")>0)
		ramal=2854
	if(InStr(A_IpAddress1,"179")>0)
		ramal=2855
	ClickToCall("http://192.9.200.245/portal/api/LigacaoAutomatica/executarLigacaoNumero/?origem="	ramal	"&destino="	StrReplace(A_ThisMenuItem,"Ligar para "))
	numero	:=	StrReplace(A_ThisMenuItem,"Ligar para ")
	dtn	:=	agora(A_Now)
	s=insert into asm.logs.dbo.log_chamadas (datetime,ip,numero) values (CONVERT(datetime2,'%dtn%',120),'%A_IPAddress1%','%numero%')
	r:=adosql(con,s)
	Menu, docall, DeleteAll
	return	;}

TabDeMapas:				;{
;{
	ControlTab	=	Mapas ->
	temmapa=
	if(strlen(idUnidade)=1)
		idUnidadem	:=	"0" idUnidade
	else
		idUnidadem	:=	idUnidade
	Loop,	C:\Seventh\Backup\Mapas\*.jpg
	{
			if(InStr(SubStr(StrReplace(A_LoopFileName,".jpg"),1,2),idUnidadem)>0)
				temmapa	.=	SubStr(StrReplace(A_LoopFileName,".jpg"),3,1)
	}
	if(InStr(temmapa,1)>0)
		ControlTab	.= "|Balança"
	if(InStr(temmapa,2)>0)
		ControlTab	.= "|Administrativo"
	if(InStr(temmapa,3)>0)
		ControlTab	.= "|Defensivos"
	if(InStr(temmapa,4)>0)
		ControlTab	.= "|Fertilizantes"
	if(InStr(temmapa,5)>0)
		ControlTab	.= "|Loja"
	if(InStr(temmapa,6)>0)
		ControlTab	.= "|Supermercado"
	if(InStr(temmapa,7)>0)
		ControlTab	.= "|AFC"
	if(InStr(temmapa,8)>0)
		ControlTab	.= "|Casa"
	GuiControl,	1:Text,	TabMapas,	% "|" ControlTab
	return	;}
Mapas:					;{
SetTimer,	DesabilitaMapa,	250
	Gui,	1:Submit,	NoHide
	if(InStr(TabMapas,"Bal")>0)	;{	digito final do id de mapa depedendendo do local
		mapid	=	1
	if(InStr(TabMapas,"Adm")>0)
		mapid	=	2
	if(InStr(TabMapas,"Def")>0)
		mapid	=	3
	if(InStr(TabMapas,"Fer")>0)
		mapid	=	4
	if(InStr(TabMapas,"Loj")>0)
		mapid	=	5
	if(InStr(TabMapas,"Sup")>0)
		mapid	=	6
	if(InStr(TabMapas,"AF")>0)
		mapid	=	7
	if(InStr(TabMapas,"Cas")>0)
		mapid	=	8	;}
	map	=		\\fs\Departamentos\monitoramento\Monitoramento\Dieisson\SMK\mapz\%idUnidade%%mapid%.jpg
	GuiControl,	1:,	EnderecoUnidade,	\\fs\Departamentos\monitoramento\Monitoramento\Dieisson\SMK\mapz\%idUnidade%%mapid%.jpg
	if(StrLen(FileExist(map))=0)	{
		GuiControl,	1:Choose,	TabMapas,	1
		return
	}
	Gui,	2:Destroy
	Gui,	2:-Caption	+AlwaysOnTop
	Gui,	2:Add, Picture,	x0	y0	vMapaP	g2GuiClose,	%	map
	Gui,	2:Show,	,	Exibição de Mapa
	GuiControl,	1:Choose,	TabMapas,	1
	return	;}
DesabilitaMapa:		;{
WinGetActiveTitle, ativo
if(Ativo="Sistema Monitoramento")	{
	Gui,	2:Destroy
	SetTimer,	DesabilitaMapa,	Off
}
return	;}	;}
2GuiClose:					;{
	Gui,	2:Destroy
	return
GuiClose:	
ExitApp	;}
									;{	Controles	Hide - Show
_Autorizados:	;{
a:=!a
if(a=1)	{
	GuiControl,	1:Show,	LVAutorizados
	GuiControl,	1:,	TAut,	- Autorizados
}	else	{
	GuiControl,	1:Hide,	LVAutorizados
	GuiControl,	1:,	TAut,	+ Autorizados	
}
return	;}
_Colaboradores:	;{
a:=!a
if(a=1)	{
	GuiControl,	1:Show,	LVColaboradores
	GuiControl,	1:,	TCol,	- Colaboradores
}	else	{
	GuiControl,	1:Hide,	LVColaboradores
	GuiControl,	1:,	TCol,	+ Colaboradores	
}
return	;}

;}

F1::								;{
	Reload	;}
