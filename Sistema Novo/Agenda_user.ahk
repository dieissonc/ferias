;@Ahk2Exe-SetMainIcon C:\Dih\zIco\2Agenda.ico
hastray	=	1
#Include ..\Libs\_.ahk

#SingleInstance,	Force
#IfWinActive	Agenda - Avisos - Ocomon - Frota
Menu,	Tray,	Icon
Menu,	Tray,	Tip,		Agenda - Avisos - Ocomon - Frota
if(A_UserName!="dsantos")
	Menu, Tray,  NoStandard
if(A_UserName="alberto" OR A_UserName="llopes" OR A_UserName="dsantos" OR A_UserName="arsilva" )
	admin	=	0
else	
	admin = 0
																;{	GUI
	;{	Tab	1	-	Agenda
if(admin=1)
	header	=	Agenda|Avisos|Ocomon|Frota|Registro|Vigilantes|Relatórios em Desconformidade|Detecções de Imagem|Sinistros em Andamento
else
	header	=	Agenda|Avisos|Ocomon|Frota|Registro
Gui, Color,		%bggui%
Gui, Color,	,	%bgctrl%
Gui,	Font,		S11	cWhite	Bold
Gui,	Add,		Tab3,				x5		y5		w1250				vtab	g_tab			AltSubmit														,	%header%
Gui,	Font
Gui,	Add,		MonthCal,		x10		y35		w230	h163	vmcall	g_date
;{	FILTROS
	Gui,	Font,	Bold	cFFFFFF
	Gui,	Add, Text,					x245		y40	w120				h20																				,	ÚLTIMOS EVENTOS
	Gui,	Add, DropDownList,	x370		y35							g_date		vOperador		AltSubmit						,	Todos|Operador 1|Operador 2|Operador 3|Operador 4|Operador 5
	Gui,	Add, Checkbox,			x500		y40	w550				g_date		vPeriodo													,	Filtrado por dia
	Gui,	Add, Text,					x1055		y40	w60																										,	Contendo:
	Gui,	Font
	Gui,	Add, Edit	,					x1120		y40	w100									vBusca
	Gui,	Add, Button	,			xp+100	y40	w20		h20	gLimpa														Center			,	X
	Gui,	Font
;}
Gui,	Add,		ListView,			x245	y65		w1000				vlv		g_listview	AltSubmit	Grid	R6					,	Data|Mensagem|Operador|Unidade|IdAviso
Gui,	Font,		S11	cWhite	Bold
Gui,	Add,		Text,				x10		y210	w1235	h20																Center	0x1000	,	Conteúdo
Gui,	Font
Gui,	Add,		Edit,				x10		y235	w1235	h300	veditbox
gosub	carrega_lv
;}
	;{	Tab	2	-	Avisos
Gui,	Tab,			2
Gui,	Font,		S11	cWhite	Bold
Gui,	Add,		Text,			x10		y38																																			,	Buscar contendo:
Gui,	Font
Gui,	Add,		Edit,			x135	y35		w250	h24		vfiltro2
Gui,	Add,		Button,		x385	y36		w250	h22					g_tab																					,	Filtrar
Gui,	Add,		ListView,		x10		y60		w1235				vlv2		g_listview2	AltSubmit	Grid	R7	NoSort						,	Agendado para:|Mensagem
Gui,	Font,		S11	cWhite	Bold	
Gui,	Add,		Text,			x10		y210	w1235	h20																						Center	0x1000	,	Conteúdo
Gui,	Font
Gui,	Add,		Edit,			xp		y235	w1235	h300	veditbox2
;}
	;{	Tab	3	-	Ocomon
Gui,	Tab,			3
Gui,	Font,		S11	cWhite	Bold
Gui,	Add,		Text,			x10		y38																																			,	Buscar contendo:
Gui,	Font
Gui,	Add,		Edit,			x135	y35		w250	h24			vfiltro3
Gui,	Add,		Button,		x385	y36		w250	h22						g_tab																				,	Filtrar
Gui,	Add,		ListView,		x10		y60		w1235					vlv3		g_listview3	AltSubmit	Grid	R7	NoSort					,	Data|Mensagem
Gui,	Font,		S11	cWhite	Bold	
Gui,	Add,		Text,			x10		y210	w1235	h20																						Center	0x1000	,	Conteúdo
Gui,	Font
Gui,	Add,		Edit,			xp		y235	w1235	h300		veditbox3
;}
	;{	Tab 4	-	Frota
Gui,	Tab,			4
Gui,	Font,		S11	cWhite	Bold
Gui,	Add,		Text,			x10		y38																																			,	Buscar contendo:
Gui,	Font
Gui,	Add,		Edit,			x135	y35		w250	h24			vfiltro4
Gui,	Add,		Button,		x385	y36		w250	h22						g_tab																				,	Filtrar
Gui,	Add,		ListView,		x10		y60		w1235					vlv4		g_listview4	AltSubmit	Grid	R7	NoSort					,	Data|Mensagem
Gui,	Font,		S11	cWhite	Bold	
Gui,	Add,		Text,			x10		y210	w1235	h20																						Center	0x1000	,	Conteúdo
Gui,	Font
Gui,	Add,		Edit,			xp		y235	w1235	h300		veditbox4
;}
	;{	Tab 5	-	Registros
Gui,	Tab,			5
;~ MsgBox % admin
if(admin=1)	{
	d	=	
	e	=	Hidden
}
else
{
	d	=	Hidden
	e	=	
}
Gui,	Add,		MonthCal,				x10		y35		w230		h163												vmcal		gregistros		%d%												;{	CALENDÁRIO
Gui,	Font,		S11	cWhite	Bold	;}
Gui,	Add,		Text,							x245	y35		w1000		h30													vt1									%d%					Center	0x1200	,	USUÁRIO	;{
Gui,	Add,		DropDownList,		x245	y65		w1000																vd1			gregistros		%d%	;}
Gui,	Add,		Text,							x245	y95		w1000		h30													vt2									%d%					Center	0x1200	,	MOTIVO		;{
Gui,	Add,		DropDownList,		x245	y125	w1000																vd2			gregistros		%d%												,	|Banheiro|Intervalo	;|Supermercado|Chimarrão
Gui,	Font	
Gui,	Add,		ListView,					x10		y210	w1235																vlv5									%d%		AltSubmit	Grid	R16		,	Operador|Saída|Retorno|Ausente|Motivo
Gui,	Add,		Button,					x10		y515																			vrel		gGeraRelatorio	%d%												,	Gerar Relatório
Gui,	Add,		Button,					x110		y515																		vmudar	gChange			%d%												,	MODO OPERADOR
if(admin=1)	{
gosub	registros
	}
Gui,	Font,	S10	Bold	cWhite
Gui,	Add,		Text,				x10		%e%					y28		w1240									h30	v_user															Center	0x1200	;{
Gui,	Font	;}
Gui,	Add,		Button,	%		"x10								y60		w"(1240/2)-5		"	"	e	"			v_snack	g_sair1"																	,	Registrar Saída Para Intervalo	;{
Gui,	Font,		S11	cWhite	Bold
Gui,	Add,		Text,		%		"x10								y85		w"(1240/2)-5		"	"	e	"	h20	v_l_sai													Right			0x1000"
Gui,	Add,		Text,		%		"x10								y108	w"(1240/2)-5		"	"	e	"	h20	v_l_volta												Right			0x1000"
Gui,	Font	;}
Gui,	Add,		Button,	%		"x"((1240/2)+5)*1	"	y60		w"(1240/2)+5	"	"	e	"			v_bath		g_sair3"																	,	Registrar Saída Para Banheiro	;{
Gui,	Font,		S11	cWhite	Bold
Gui,	Add,		Text,		%		"x"((1240/2)+5)*1	"	y85		w"(1240/2)+5	"	"	e	"	h20	v_b_sai												Right			0x1000"
Gui,	Add,		Text,		%		"x"((1240/2)+5)*1	"	y108	w"(1240/2)+5	"	"	e	"	h20	v_b_volta											Right			0x1000"
Gui,	Font	;}	;}
;{	DESABILITADOS
;~ Gui,	Add,		Button,%		"x"1240/3*2	"	y60		w"(1240/3)-5	"				v_market	g_sair4												",	Registrar Saída Para Supermercado
;~ Gui,	Font,		S11	cWhite	Bold
	;~ Gui,	Add,		Text,	%		"x"1240/3*2	"	y85		w"(1240/3)-5	"	h20		v_s_sai							Right			0x1000"
	;~ Gui,	Add,		Text,	%		"x"1240/3*2	"	y108	w"(1240/3)-5	"	h20		v_s_volta						Right			0x1000"
;~ Gui,	Font
	;~ Gui,	Add,		Button,%		"x945		y60		w"(1240/4)-5	"				v_mate		g_sair5												",	Registrar Saída Para Chimarrão
;~ Gui,	Font,		S11	cWhite	Bold
	;~ Gui,	Add,		Text,	%		"x945		y85		w"(1240/4)-5	"	h20		v_m_sai						Right			0x1000"
	;~ Gui,	Add,		Text,	%		"x945		y108	w"(1240/4)-5	"	h20		v_m_volta					Right			0x1000"
;~ Gui,	Font
	;~ Gui,	Add,		Button,	x275		y60		w200					v_coffee		g_sair2															,	Registrar Saída Para Café/Água
;~ Gui,	Font,		S11	cWhite	Bold
	;~ Gui,	Add,		Text,			x275		y85		w200		h20		v_c_sai							Right			0x1000
	;~ Gui,	Add,		Text,			x275		y108	w200		h20		v_c_volta						Right			0x1000
;~ Gui,	Font	;}
;}
	;{	Tab 6	-	Vigilantes
Gui,	Tab,			6
Gui,	Font,		S11	cWhite	Bold
Gui,	Add,		Text,				x10		y38																																	,	Buscar contendo:
Gui,	Font
Gui,	Add,		Edit,			x135	y35		w250	h24			vfiltro6
Gui,	Add,		Button,		x385	y36		w250	h22						g_tab																				,	Filtrar
Gui,	Add,		ListView,		x10		y60		w1235					vlv6		g_listview6	AltSubmit	Grid	R7	NoSort					,	Data|Mensagem|Vigilante
Gui,	Font,		S11	cWhite	Bold	
Gui,	Add,		Text,				x10		y210	w1235	h20																				Center	0x1000	,	Conteúdo
Gui,	Font
Gui,	Add,		Edit,			xp		y235	w1235	h300		veditbox6
;}
	;{	Tab 7	-	Desconformidades
Gui,	Tab,			7
Gui,	Font,		S11	cWhite	Bold
Gui,	Add,		Text,						x5		y35		w100		h20													vt3															Center	0x1200,	USUÁRIO
Gui,	Font
Gui,	Add,		DropDownList,		x105	y35		w300																vd3			gdesconformes
Gui,	Add,		ListView,					x10		y60		w1235					vlv7		g_listview7	AltSubmit	Grid	R20																	,	Data|Unidade|Mensagem|Operador|Motivo|idcliente
Gui,	Font,		S11	cWhite	Bold	
Gui,	Add,		Text,						x10		y430	w1235	h20																														Center	0x1000,	Conteúdo
Gui,	Font
Gui,	Add,		Edit,						xp		y460	w1235	h75		veditbox7
;}
	;{	Tab 8	-	Detecção
Gui,	Tab,			8
Gui,	Font,		S11	cWhite	Bold
Gui,	Add,		Text,						x5		y35		w100		h20																													Center	0x1200,	Tipo
Gui,	Font
Gui,	Add,		DropDownList,		x105	y35		w300																vd4			gdeteccao														,	||Inibido|Ocorrência
Gui,	Add,		ListView,					x10		y60		w1235					vlv8		g_listview8	AltSubmit	Grid	R13	NoSort													,	Camera|Gerado|Exibido|Encerrado|Operador|Tipo de Evento|Descrição do Ocorrido
Gui,	Font,		S11	cWhite	Bold	
Gui,	Add,		Text,						x10		y305	w1235	h20																														Center	0x1000,	Conteúdo
Gui,	Font
Gui,	Add,		Edit,						xp		y325	w1235	h210		veditbox8
;}
	;{	Tab 9	-	Sinistros
Gui,	Tab,			9
Gui,	Add,		ListView,					x10		y35		w1235					vlv9							AltSubmit	Grid	R28	NoSort													,	Operador|Usuário do Iris|Hora Inicial do Sinistro|Hora Final do Sinistro|Verificou Imagens|Ocorrências
;}
Gui,					Show,						x0		y0																																										,	Agenda - Avisos - Ocomon - Frota
	Send,	{Down}
if(trocou=1)	{
trocou	=
GuiControl,	Choose,	tab,	5
}
ToolTip
return	;}
limpa:
return
Change:													;{
change	:=	!change
if(change=1)	{
	GuiControl,	Hide,	mcal
	GuiControl,	Hide,	t1
	GuiControl,	Hide,	d1
	GuiControl,	Hide,	t2
	GuiControl,	Hide,	d2	
	GuiControl,	Hide,	rselect	
	GuiControl,	Hide,	lv5
	GuiControl,	Hide,	rel
	GuiControl,	Show,	_user
	GuiControl,	Show,	_snack
	GuiControl,	Show,	_bath
	GuiControl,	Show,	_l_sai
	GuiControl,	Show,	_l_volta
	GuiControl,	Show,	_l_bath
	GuiControl,	Show,	_b_sai
	GuiControl,	Show,	_b_volta
	GuiControl,	,	_user,	Usuário logado na estação:	%usuarioatual%
	GuiControl,	,	mudar,	MODO ADMIN
}
if(change=0)	{
	GuiControl,	Show,	mcal
	GuiControl,	Show,	t1
	GuiControl,	Show,	d1
	GuiControl,	Show,	t2
	GuiControl,	Show,	d2	
	GuiControl,	Show,	rselect	
	GuiControl,	Show,	lv5
	GuiControl,	Show,	rel
	GuiControl,	Hide,	_user
	GuiControl,	Hide,	_snack
	GuiControl,	Hide,	_bath
	GuiControl,	Hide,	_l_sai
	GuiControl,	Hide,	_l_volta
	GuiControl,	Hide,	_l_bath
	GuiControl,	Hide,	_b_sai
	GuiControl,	Hide,	_b_volta
	GuiControl,	,	mudar,	MODO OPERADOR
}
return	;}
_date:														;{
	Gui,	Submit,	NoHide
	if(StrLen(Busca)>"0")	{
		b	=	AND	p.Mensagem	LIKE	'`%%Busca%`%'
	}
	else
		b	=
	if(periodo=1)	{	;{	Controle das guis
		FormatTime,	diaAntes,	%mcall%,	YDay
		FormatTime,	mcall,	%mcall%,	yyyy-MM-dd
		FormatTime,	Today,	%A_Now%,	yyyy-MM-dd
		periodox	:=	A_YDay - diaAntes
		GuiControl,	+cYellow	+Redraw,	periodo
		if(operador=1)	;{
			GuiControl,	,	Periodo,	Filtrado o período de %mcall% à %Today% com TODOS os operadores	;}
		if(operador=2)	{
			op	:=	operador -1
			GuiControl,	,	Periodo,	Filtrado o período de %mcall% à %Today% apenas eventos do OPERADOR %op%
		}
		if(operador=3)	{
			op	:=	operador -1
			GuiControl,	,	Periodo,	Filtrado o período de %mcall% à %Today% apenas eventos do OPERADOR %op%
		}
		if(operador=4)	{
			op	:=	operador -1
			GuiControl,	,	Periodo,	Filtrado o período de %mcall% à %Today% apenas eventos do OPERADOR %op%
		}
		if(operador=5)	{
			op	:=	operador -1
			GuiControl,	,	Periodo,	Filtrado o período de %mcall% à %Today% apenas eventos do OPERADOR %op%
		}
		if(operador=6)	{
			op	:=	operador -1
			GuiControl,	,	Periodo,	Filtrado o período de %mcall% à %Today% apenas eventos do OPERADOR %op%
		}
		if(operador=7)	{
			op	:=	operador -1
			GuiControl,	,	Periodo,	Filtrado o período de %mcall% à %Today% apenas eventos do MONITORAMENTO
		}
		if(periodox=0)	{
			periodo	:=	"DATEDIFF(DAY,p.QuandoAvisar,'"	mcall	"') = "	periodox
			if(operador=1)	;{
				GuiControl,	,	Periodo,	Filtrado a data de %mcall% com TODOS os operadores	;}
			if(operador=2)	{
				op	:=	operador -1
				GuiControl,	,	Periodo,	Filtrado a data de %mcall% apenas eventos do OPERADOR %op%
			}
			if(operador=3)	{
				op	:=	operador -1
				GuiControl,	,	Periodo,	Filtrado a data de %mcall% apenas eventos do OPERADOR %op%
			}
			if(operador=4)	{
				op	:=	operador -1
				GuiControl,	,	Periodo,	Filtrado a data de %mcall% apenas eventos do OPERADOR %op%
			}
			if(operador=5)	{
				op	:=	operador -1
				GuiControl,	,	Periodo,	Filtrado a data de %mcall% apenas eventos do OPERADOR %op%
			}
			if(operador=6)	{
				op	:=	operador -1
				GuiControl,	,	Periodo,	Filtrado a data de %mcall% apenas eventos do OPERADOR %op%
			}
		}
		else
			periodo	:=	"CAST(Quandoavisar AS DATE) >= '"	mcall	"'	and CAST(Quandoavisar AS DATE) <= '"	Today	"'"
	}
	else
	{
		GuiControl,	+cWhite +Redraw, periodo
		FormatTime,	mcall,	%mcall%,	yyyy-MM-dd
		periodo = CONVERT(VARCHAR(25), Quandoavisar, 126) like '%mcall%`%'
		GuiControl,	,	Periodo,	Filtrado por dia
	}	;}
	if(operador=1)	;{
		operador	=		;}
	if(operador=2)	;{
		operador	=	AND	p.Assunto	=	'1'	;}
	if(operador=3)	;{
		operador	=	AND	p.Assunto	=	'2';}
	if(operador=4)	;{
		operador	=	AND	p.Assunto	=	'3'	;}
	if(operador=5)	;{
		operador	=	AND	p.Assunto	=	'4'	;}
	if(operador=6)	;{
		operador	=	AND	p.Assunto	=	'5'	;}
	lastrow	=
	FormatTime,	yday,	%mcall%,	yyyy-MM-dd
selected	=	1
LV_Delete()	;}
carrega_lv:												;{
if(StrLen(periodo)>=)
	Gui,	Submit,	NoHide
FormatTime,	mcall,	%mcall%,	yyyy-MM-dd
if(periodo=0)
	periodo	= CONVERT(VARCHAR(25), Quandoavisar, 126) like '%mcall%`%'
Gui,	ListView,	lv
LV_Delete()
data	:=	SubStr(mcall,1,4)	"-"	SubStr(mcall,5,2)	"-"	SubStr(mcall,7,2)
sqlv =
(
	SELECT p.IdCliente, p.QuandoAvisar, p.Mensagem, p.Assunto, c.Nome,	p.Idaviso
	FROM [IrisSQL].[dbo].[Agenda] p
	LEFT JOIN [IrisSQL].[dbo].[Clientes] c ON p.IdCliente = c.IdUnico
	WHERE %periodo%
	%operador%
	%b%
	ORDER BY 6 DESC
)
fill	:=	adosql(con,sqlv)
Loop, % fill.MaxIndex()-1
{
LV_ModifyCol(1,115)
LV_ModifyCol(1,Sort)
LV_ModifyCol(2,600)
LV_ModifyCol(3,60)
LV_ModifyCol(4,200)
LV_ModifyCol(5,0)
	hour	:=	fill[A_Index+1,2]
	oper	:=	fill[A_Index+1,3]
	oper	:=	 RegExReplace(oper,"(^|\R)\K\s+")
	subj		:=	fill[A_Index+1,4]
	IfInString,	subj,	Informou
		continue
	unit		:=	fill[A_Index+1,5]
	idav		:=	fill[A_Index+1,6]
	if(A_Index=1)
		last_id	:=	idav
	StringUpper,	unit,	unit,	T
	LV_Add("",	hour,	oper,	subj,	unit,	idav)
}
if(selected=1)	{
	row	:=	LV_GetNext()
	if(row=0)
		row			=		1
	LV_GetText(edb, row, 2)
	edb		:=	 RegExReplace(oper,"(^|\R)\K\s+")
	if(StrLen(edb)<6)
		edb	=
	Gui,	Font,	S11
	GuiControl,	Font,	editbox
	GuiControl,	,	editbox,	%	edb
	selected =
}
SetTimer,	novo_email,	500
return	;}
registros:													;{
Gui,	Submit,	NoHide
Gui,	ListView,	lv5
LV_Delete()
LV_ModifyCol(2,115)
LV_ModifyCol(3,115)
LV_ModifyCol(4,60)
LV_ModifyCol(5,90)
LV_ModifyCol(1,"Center")
LV_ModifyCol(2,"Center")
LV_ModifyCol(3,"Center")
LV_ModifyCol(4,"Center")
LV_ModifyCol(5,"Center")
if(d1!="")	{	;	Contém filtro por nome
	reg	=	
	(
		SELECT [login],[login2] FROM [ASM].[Sistema_Monitoramento].[dbo].[Operadores]	WHERE nome = '%d1%'
	)
	reg	:=	adosql(con,reg)
	res1	:=	StrReplace(reg[2,1],"`r`n")
	res2	:=	StrReplace(reg[2,2],"`r`n")
	if(StrLen(res2)=0)
		if(StrLen(d2)>0)	;Filtro por nome e tipo, com apenas 1 user
			isd	=	WHERE	nome	=	'%res1%'	AND	tipo	=	'%d2%'	AND	tipo	!=	'TESTE'
		else
			isd	=	WHERE	nome	=	'%res1%'	AND	tipo	!=	'TESTE'
	else
		if(StrLen(d2)>0)	; Filtro por nome e tipo, com 2 user
			isd	=	WHERE	(nome	=	'%res1%'	OR	nome	=	'%res2%')	AND	tipo	=	'%d2%'	AND	tipo	!=	'TESTE'
		else
			isd	=	WHERE	(nome	=	'%res1%'	OR	nome	=	'%res2%')	AND	tipo	!=	'TESTE'
}
else
	if(StrLen(d2)>0)	;	Filtro por tipo apenas
		isd	=	WHERE	tipo	=	'%d2%'	AND	tipo	!=	'TESTE'
	else
		isd	=
mc	:=	SubStr(mcal,1,4)	"-"	SubStr(mcal,5,2)	"-"	SubStr(mcal,7,2)
if(StrLen(isd)=0)
	isd		=	WHERE	CONVERT(VARCHAR(25), hora_saiu, 126) like '%mc%`%'	AND	tipo	!=	'TESTE'
else
	isd		.=	" and	CONVERT(VARCHAR(25), hora_saiu, 126) like '" mc "`%'	AND	tipo	!=	'TESTE'"

r	=
(
	SELECT [nome],[hora_saiu],[hora_retornou],[tempo_fora],[tipo]	FROM [ASM].[Sistema_Monitoramento].[dbo].[Controle_Saidas]	%isd%
)
r	:=	adosql(con,r)
Loop,	%	r.MaxIndex()-1
	LV_Add("",r[A_Index+1,1],r[A_Index+1,2],r[A_Index+1,3],r[A_Index+1,4],r[A_Index+1,5])
LV_ModifyCol(1,100)
return			;}
deteccao:												;{
	Gui,	Submit,	NoHide
	Gui,	ListView,	lv8
	if(d4!="")	;	Contém filtro por tipo
		whered4 =	WHERE [Ocorrido]	like	'%d4%`%'
	else
		whered4	=
	dete	=	
	(
				SELECT	TOP(500)
					[detect_id]
					,[Camera]
					,[Gerado]
					,[Exibido]
					,[Finalizado]
					,[Computador]
					,[Ocorrido]
					,[Descricao]
					,[IP]
	FROM [MotionDetection].[dbo].[Encerrados]
	%whered4%
	ORDER BY 1 DESC
	)
	dete	:=	adosql(con,dete)
	LV_Delete()
	LV_ModifyCol(1,115)
	LV_ModifyCol(2,120)
	LV_ModifyCol(3,120)
	LV_ModifyCol(4,120)
	LV_ModifyCol(5,80)
	LV_ModifyCol(6,120)
	LV_ModifyCol(7,600)
	Loop,	%	dete.MaxIndex()-1
	{
		a	:=	dete[A_Index+1,2]
		b	:=	dete[A_Index+1,3]
		c	:=	dete[A_Index+1,4]
		d	:=	dete[A_Index+1,5]
		e	:=	dete[A_Index+1,6]
		f	:=	dete[A_Index+1,7]
		g	:=	dete[A_Index+1,8]
		LV_Add("",	a,	b,	c,	d,	e,	f,	g)
	}
	LV_ModifyCol(1,Sort)
return	;}
desconformes:										;{
	Gui,	Submit,	NoHide
	Gui,	ListView,	lv7
	LV_Delete()
	if(d3!="")	{	;	Contém filtro por nome
	regn	=	
	(
		SELECT [login],[login2] FROM [ASM].[Sistema_Monitoramento].[dbo].[Operadores]	WHERE nome = '%d3%'
	)
	regn	:=	adosql(con,regn)
	reg1	:=	StrReplace(regn[2,1],"`r`n")
	reg2	:=	StrReplace(regn[2,2],"`r`n")
	if(StrLen(reg2)=0)
		operador	=	AND	a.OperadorFinalizou	=	'%reg1%'	AND	a.tipo	!=	'TESTE'
	else
		operador	=	AND	(a.OperadorFinalizou	=	'%reg1%'	OR	a.OperadorFinalizou	=	'%reg2%')	AND	a.tipo	!=	'TESTE'
	}
	else	;{
		operador	=		;}
	desconformidades	=
	(
	SELECT	a.Disparo,	a.Observacoes_conta,	c.desconformidade,	a.OperadorFinalizou,	b.Nome	FROM [IrisSQL].[dbo].[Procedimentos] a
	LEFT		JOIN	[IrisSQL].[dbo].[Clientes]	b	ON	a.IdCliente	=	b.IdUnico
	LEFT		JOIN	[ASM].[Sistema_Monitoramento].[dbo].[desconformidades]	c	ON a.IdSequencia	=	c.nr_procedimento
	WHERE	c.nr_procedimento	<>	''
	%operador%
	ORDER	BY	1	DESC
	)
	desconformidades	:=	adosql(con,desconformidades)
	Loop,	%	desconformidades.MaxIndex()-1
	{
	LV_ModifyCol(1,115)
	LV_ModifyCol(2,200)
	LV_ModifyCol(3,300)
	LV_ModifyCol(4,100)
	LV_ModifyCol(5,500)
		hour		:=	desconformidades[A_Index+1,1]
		desc		:=	desconformidades[A_Index+1,2]
		motivo	:=	desconformidades[A_Index+1,3]
		oper		:=	desconformidades[A_Index+1,4]
		unidade	:=	desconformidades[A_Index+1,5]
		LV_Add("",	hour,	unidade,	desc,	oper,	motivo)
	}
	LV_ModifyCol(1,Sort)
return	;}
;{	LISTVIEWS
_listview:													;{
Gui,	ListView,	lv
row	:=	LV_GetNext()
if(row=0)
	row			=		1
if A_GuiEvent = Normal
{
	LV_GetText(edb, A_EventInfo, 2)
	Loop
	{
		edb := RegExReplace(edb, "\R+\R", "`r`n ")
		if ErrorLevel = 0
			break
	}
	Gui,	Font,	S11
	GuiControl,	Font,	editbox
	GuiControl,	,	editbox,	%	edb
	return
}
LV_GetText(edb, row, 2)
Gui,	Font,	S11
GuiControl,	Font,	editbox
GuiControl,	,	editbox,	%	edb
return	;}
_listview2:												;{
Gui,	ListView,	lv2
row2	:=	LV_GetNext()
if(row2=0)
	row2			=		1
if A_GuiEvent = Normal
{
	LV_GetText(edb, A_EventInfo, 2)
	Loop
	{
		edb := RegExReplace(edb, "\R+\R", "`r`n ")
		if ErrorLevel = 0
			break
	}
	Gui,	Font,	S11
	GuiControl,	Font,	editbox2
	GuiControl,	,	editbox2,	%	edb
	return
}
LV_GetText(edb, row2, 2)
Gui,	Font,	S11
GuiControl,	Font,	editbox2
GuiControl,	,	editbox2,	%	edb
return	;}
_listview3:												;{
Gui,	ListView,	lv3
row3	:=	LV_GetNext()
if(row3=0)
	row3		=		1
if A_GuiEvent = Normal
{
	LV_GetText(edb, A_EventInfo, 2)
	Loop
	{
		edb := RegExReplace(edb, "\R+\R", "`r`n ")
		if ErrorLevel = 0
			break
	}
	Gui,	Font,	S11
	GuiControl,	Font,	editbox3
	GuiControl,	,	editbox3,	%	edb
	return
}
LV_GetText(edb, row3, 2)
Gui,	Font,	S11
GuiControl,	Font,	editbox3
GuiControl,	,	editbox3,	%	edb
return	;}
_listview4:												;{
Gui,	ListView,	lv4
row4	:=	LV_GetNext()
if(row4=0)
	row4			=		1
if A_GuiEvent = Normal
{
	LV_GetText(edb, A_EventInfo, 2)
	Loop
	{
		edb := RegExReplace(edb, "\R+\R", "`r`n ")
		if ErrorLevel = 0
			break
	}
	Gui,	Font,	S11
	GuiControl,	Font,	editbox4
	GuiControl,	,	editbox4,	%	edb
	return
}
LV_GetText(edb, row4, 2)
Gui,	Font,	S11
GuiControl,	Font,	editbox4
GuiControl,	,	editbox4,	%	edb
return	;}
_listview6:												;{
Gui,	ListView,	lv6
row6	:=	LV_GetNext()
if(row6=0)
	row6			=		1
if A_GuiEvent = Normal
{
	LV_GetText(edb, A_EventInfo, 2)
	Loop
	{
		edb := RegExReplace(edb, "\R+\R", "`r`n ")
		if ErrorLevel = 0
			break
	}
	Gui,	Font,	S11
	GuiControl,	Font,	editbox6
	GuiControl,	,	editbox6,	%	edb
	return
}
LV_GetText(edb, row6, 2)
Gui,	Font,	S11
GuiControl,	Font,	editbox6
GuiControl,	,	editbox6,	%	edb
return	;}
_listview7:												;{
Gui,	ListView,	lv7
row7	:=	LV_GetNext()
if(row7=0)
	row7			=	1
if A_GuiEvent =	I
{
	LV_GetText(edb, A_EventInfo, 3)
	LV_GetText(idc, A_EventInfo, 6)
	Loop	;{	Remove line breaks
	{
		edb := RegExReplace(edb, "\R+\R", "`r`n ")
		if ErrorLevel = 0
			break
	}	;}
	Gui,	Font,	S11
	if(edb="Mensagem")	;{
		return	;}
	BuscaSensor(nrSensor,idc)
	GuiControl,	Font,	editbox7
	StringReplace,  edb, edb, %forReplace%, [%nrSensor%] - [%nomeSensor%]			;	remove o @numero@
	GuiControl,	,	editbox7,	%	edb
	return
}
LV_GetText(edb, row7, 3)
LV_GetText(idc, row7, 6)
BuscaSensor(nrSensor,idc)
Gui,	Font,	S11
StringReplace,  edb, edb, %forReplace%, [%nrSensor%] - [%nomeSensor%]			;	remove o @numero@
GuiControl,	Font,	editbox7
GuiControl,	,	editbox7,	%	edb
return	;}
_listview8:												;{
Gui,	ListView,	lv8
row8	:=	LV_GetNext()
if(row8=0)
	row8			=		1
if A_GuiEvent = Normal
{
	LV_GetText(edb, A_EventInfo, 7)
	Loop
	{
		edb := RegExReplace(edb, "\R+\R", "`r`n ")
		if ErrorLevel = 0
			break
	}
	Gui,	Font,	S11
	if(edb="Mensagem")
		return
	GuiControl,	Font,	editbox8
	GuiControl,	,	editbox8,	%	edb
	return
}
LV_GetText(edb, row8, 7)
Gui,	Font,	S11
GuiControl,	Font,	editbox8
GuiControl,	,	editbox8,	%	edb
return	;}
;}
_tab:														;{
Gui,	Submit,	NoHide
if(tab=1)	{
	GuiControl,	,	filtro2
	GuiControl,	,	filtro3
	GuiControl,	,	filtro4
	GuiControl,	,	filtro6
	GuiControl,	,	filtro7
	GuiControl,	Focus,	lv
}
if(tab=2)	{
	GuiControl,	,	filtro3
	GuiControl,	,	filtro4
	GuiControl,	,	filtro6
	GuiControl,	,	filtro7
	Gui,	ListView,	lv2
	if(filtro2="")
		filtrar	=
	else
		filtrar	:=	"	AND	p.Mensagem like	'%"	filtro2	"%'"
	LV_Delete()
	sqlv =
	(
		SELECT p.IdCliente, p.QuandoAvisar, p.Mensagem, p.Assunto, c.Nome
		FROM [IrisSQL].[dbo].[Agenda] p
		LEFT JOIN [IrisSQL].[dbo].[Clientes] c ON p.IdCliente = c.IdUnico
		WHERE c.[Nome]	=	'Avisos Monitoramento'
		%filtrar%
		ORDER BY 2 DESC
	)
	fill	:=	adosql(con,sqlv)
	Loop, % fill.MaxIndex()-1
	{
	LV_ModifyCol(1,115)
	LV_ModifyCol(2,1100)
		hour	:=	fill[A_Index+1,2]
		desc	:=	fill[A_Index+1,3]
		LV_Add("",	hour,	desc)
	}
	LV_ModifyCol(1,Sort)
	GuiControl,	Focus,	lv2
}
if(tab=3)	{
	Gui,	ListView,	lv3
	GuiControl,	,	filtro2
	GuiControl,	,	filtro4
	GuiControl,	,	filtro6
	GuiControl,	,	filtro7
	if(filtro3="")
		filtrar	=
	else
		filtrar	:=	"	AND	p.Mensagem like	'%"	filtro3	"%'"
	LV_Delete()
	sqlv =
	(
		SELECT p.IdCliente, p.QuandoAvisar, p.Mensagem, p.Assunto, c.Nome
		FROM [IrisSQL].[dbo].[Agenda] p
		LEFT JOIN [IrisSQL].[dbo].[Clientes] c ON p.IdCliente = c.IdUnico
		WHERE c.[Nome]	=	'Ocomon'
		%filtrar%
		ORDER BY 2 DESC
	)
	fill	:=	adosql(con,sqlv)
	Loop, % fill.MaxIndex()-1
	{
	LV_ModifyCol(1,115)
	LV_ModifyCol(2,1100)
		hour	:=	fill[A_Index+1,2]
		desc	:=	fill[A_Index+1,3]
		LV_Add("",	hour,	desc)
	}
	LV_ModifyCol(1,Sort)
	GuiControl	Focus,	lv3
}
if(tab=4)	{
	Gui,	ListView,	lv4
	GuiControl,	,	filtro2
	GuiControl,	,	filtro3
	GuiControl,	,	filtro6
	GuiControl,	,	filtro7
	if(filtro4="")
		filtrar	=
	else
		filtrar	:=	"	AND	p.Mensagem like	'%"	filtro4	"%'"
	LV_Delete()
	sqlv =
	(
		SELECT p.IdCliente, p.QuandoAvisar, p.Mensagem, p.Assunto, c.Nome
		FROM [IrisSQL].[dbo].[Agenda] p
		LEFT JOIN [IrisSQL].[dbo].[Clientes] c ON p.IdCliente = c.IdUnico
		WHERE c.[Nome]	=	'Caminhoes'
		%filtrar%
		ORDER BY 2 DESC
	)
	fill	:=	adosql(con,sqlv)
	Loop, % fill.MaxIndex()-1
	{
	LV_ModifyCol(1,115)
	LV_ModifyCol(2,1100)
		hour	:=	fill[A_Index+1,2]
		desc	:=	fill[A_Index+1,3]
		LV_Add("",	hour,	desc)
	}
	LV_ModifyCol(1,Sort)
	GuiControl	Focus,	lv4
}
if(tab=5)	{
	u			=	;{	user logado
	(
		SELECT	TOP(1)	[LOG~USUARIO],[LOG~ORDEM]
		FROM	[BdIrisLog].[dbo].[SYS~Log]
		WHERE	[LOG~DADOS]	=	'Login no Painel de Monitoramento.'
		AND	[LOG~ESTACAO]	=	'%A_ComputerName%'
		ORDER	BY	2	DESC
	)
	u	:=	adosql(con,u)
	usuarioatual	:=	u[2,1]

	if(StrLen(u[2,1])<3)	{
		usuarioatual	:=	A_IPAddress1
	}
	gosub	verifica
	GuiControl,	,	_user,	Usuário logado na estação:	%usuarioatual%	;}
	login	=	;{
	(
		SELECT [nome] FROM [ASM].[Sistema_Monitoramento].[dbo].[Operadores]	ORDER BY 1
	)
	login	:=	adosql(con,login)
	Loop,	%	login.MaxIndex()-1
		l1	.=	"|" login[A_Index+1,1] 
	GuiControl,	,	d1,	|%l1%	;}
	SetTimer,	Checagem,	500
}
if(tab=6)	{
	Gui,	ListView,	lv6
	GuiControl,	,	filtro2
	GuiControl,	,	filtro3
	GuiControl,	,	filtro4
	GuiControl,	,	filtro7
	LV_Delete()
	sqlv =
	(
	 SELECT		Disparo,	Observacoes_conta,	OperadorDisparo	FROM [IrisSQL].[dbo].[Procedimentos]
	 WHERE cliente = '90001'	 AND Particao ='001'	 AND Observacoes_conta LIKE '`%%filtro6%`%'
	 ORDER BY 1 DESC
	)
	fill	:=	adosql(con,sqlv)
	Loop, % fill.MaxIndex()-1
	{
	LV_ModifyCol(1,115)
	LV_ModifyCol(2,980)
	LV_ModifyCol(3,100)
		hour	:=	fill[A_Index+1,1]
		desc	:=	fill[A_Index+1,2]
		op		:=	fill[A_Index+1,3]
		LV_Add("",	hour,	desc,	op)
	}
	LV_ModifyCol(1,Sort)
	GuiControl	Focus,	lv6
}
if(tab=7)	{
	Gui,	ListView,	lv7
	login =
	login	=	;{
	(
		SELECT [nome] FROM [ASM].[Sistema_Monitoramento].[dbo].[Operadores]
		WHERE	Nome	!= 'Alberto'
		ORDER BY 1
	)
	login	:=	adosql(con,login)
	Loop,	%	login.MaxIndex()-1
		l1	.=	"|" login[A_Index+1,1] 
	GuiControl,	,	d3,	|%l1%	;}
	GuiControl,	,	filtro2
	GuiControl,	,	filtro3
	GuiControl,	,	filtro4
	GuiControl,	,	filtro6
	LV_Delete()
	sqlv =
	(
	SELECT	a.Disparo,	a.Observacoes_conta,	c.desconformidade,	a.OperadorFinalizou,	b.Nome,	b.IdUnico	FROM [IrisSQL].[dbo].[Procedimentos] a
	LEFT		JOIN	[IrisSQL].[dbo].[Clientes]	b	ON	a.IdCliente	=	b.IdUnico
	LEFT		JOIN	[ASM].[Sistema_Monitoramento].[dbo].[desconformidades]	c	ON a.IdSequencia	=	c.nr_procedimento
	WHERE	c.nr_procedimento	<>	''
	ORDER	BY	1	DESC
	)
	fill	:=	adosql(con,sqlv)
	Loop, % fill.MaxIndex()-1
	{
	LV_ModifyCol(1,115)
	LV_ModifyCol(2,200)
	LV_ModifyCol(3,300)
	LV_ModifyCol(4,100)
	LV_ModifyCol(5,500)
	LV_ModifyCol(6,0)
		hour		:=	fill[A_Index+1,1]
		desc		:=	fill[A_Index+1,2]
		motivo	:=	fill[A_Index+1,3]
		oper		:=	fill[A_Index+1,4]
		unidade	:=	fill[A_Index+1,5]
		idunida	:=	fill[A_Index+1,6]
		
		LV_Add("",	hour,	unidade,	desc,	oper,	motivo,	idunida)
	}
	LV_ModifyCol(1,Sort)
	GuiControl	Focus,	lv7
}
if(tab=8)	{
	Gui,	ListView,	lv8
	eventos	=
	(
		SELECT	TOP(500)
						[detect_id]
						,[Camera]
		 				,[Gerado]
		 				,[Exibido]
		 				,[Finalizado]
						,[Computador]
						,[Ocorrido]
						,[Descricao]
						,[IP]
		FROM [MotionDetection].[dbo].[Encerrados]
		ORDER BY 1 DESC
	)
	eventos	:=	adosql(con,eventos)
	LV_Delete()
	LV_ModifyCol(1,115)
	LV_ModifyCol(2,120)
	LV_ModifyCol(3,120)
	LV_ModifyCol(4,120)
	LV_ModifyCol(5,80)
	LV_ModifyCol(6,120)
	LV_ModifyCol(7,600)
	Loop,	%	eventos.MaxIndex()-1
	{
		a	:=	eventos[A_Index+1,2]
		b	:=	eventos[A_Index+1,3]
		c	:=	eventos[A_Index+1,4]
		d	:=	eventos[A_Index+1,5]
		e	:=	eventos[A_Index+1,6]
		f	:=	eventos[A_Index+1,7]
		g	:=	eventos[A_Index+1,8]
		
		LV_Add("",	a,	b,	c,	d,	e,	f,	g)
	}
	LV_ModifyCol(1,Sort)
	GuiControl	Focus,	lv8
}
if(tab=9)	{
	Gui,	ListView,	lv9
	eventos	=
	(
		SELECT			[id]		,[Operador]		,[User_Iris]		,[Hora_Sinistro]		,[Hora_Encerrado]		,[Verificar]		,[Eventos_Não_Exibidos]
		FROM				[MotionDetection].[dbo].[Sinistro]
		ORDER	BY	1	DESC
	)
	eventos	:=	adosql(con,eventos)
	LV_Delete()
	LV_ModifyCol(1,85)
	LV_ModifyCol(2,100)
	LV_ModifyCol(3,120)
	LV_ModifyCol(4,120)
	LV_ModifyCol(5,100)
	LV_ModifyCol(6,120)
	Loop,	%	eventos.MaxIndex()-1
	{
		a	:=	eventos[A_Index+1,2]
		b	:=	eventos[A_Index+1,3]
		c	:=	eventos[A_Index+1,4]
		d	:=	eventos[A_Index+1,5]
		e	:=	eventos[A_Index+1,6]
		if(e=1)
			e	=	Sim
		else
			e	=	Não
		f	:=	eventos[A_Index+1,7]
		LV_Add("",	a,	b,	c,	d,	e,	f)
	}
	LV_ModifyCol(1,Sort)
	GuiControl	Focus,	lv9
}
return	;}
~Enter::													;{
~NumpadEnter::
if(tab!=1)
	return
Gui,	Submit,	NoHide
goto	_date
;}
Esc::															;{
GuiClose:		;{
ExitApp	;}	;}
																;{	Controle de horários
GeraRelatorio:	;{
Gui,	relatorio:Add,	Text,						x5		y0		w110	h20		0x1000												,	Operador
Gui,	relatorio:Add,	Text,						x5		y30		w110	h20		0x1000												,	Motivo
Gui,	relatorio:Add,	Text,						x5		y60		w110	h20		0x1000												,	Data	Inicial
Gui,	relatorio:Add,	Text,						x5		y90		w110	h20		0x1000												,	Data	Final
Gui,	relatorio:Add,	DropDownList,	x115	y0		w160	h20						voperador				R10		,	|%l1%
Gui,	relatorio:Add,	DropDownList,	x115	y30		w160	h21						vmotivo					R5		,	|Banheiro|Chimarrão|Intervalo|Supermercado
Gui,	relatorio:Add,	DateTime,			x115	y60		w160	h20						vd_inicio								,	
Gui,	relatorio:Add,	DateTime,			x115	y90		w160	h20						vd_final								,	
Gui,	relatorio:Add,	Radio,					x5		y120	w50	h30							vr1										,	Nome
Gui,	relatorio:Add,	Radio,					x55		y120	w75	h30							vr2				Checked			,	Hora Saída
Gui,	relatorio:Add,	Radio,					x135	y120	w75	h30							vr3										,	Tempo Fora
Gui,	relatorio:Add,	Radio,					x217	y120	w40	h30							vr4										,	Tipo
Gui,	relatorio:Add,	Text,						x5		y150	w270	h140	0x1000	vquery								,
Gui,	relatorio:Add,	Button,				x5		y300	w270	h30											ggerar				,	Gerar
Today	:=	A_Now
mes		:=	SubStr(Today,5,2)-1
if(mes	=	0)	;{
	mes	=	12	;}
if(StrLen(mes)=1)
	mes	=	0%mes%
Today	:=	A_Year mes "01"
FormatTime, mesPassado,	%Today%,	yyyyMMdd
Gui,	relatorio:Show,	,	Gerador de Relatórios
GuiControl,	relatorio:,	d_inicio,	%	mesPassado
return	;}
_sair1:				;{	Intervalo
snack				:=	!snack
if(snack=1)	{
	GuiControl,	Disable,	_market
	GuiControl,	Disable,	_bath
	GuiControl,	Disable,	_snack
	GuiControl,	Disable,	_coffee
	GuiControl,	Disable,	_mate
	GuiControl,	,	_l_sai
	GuiControl,	,	_l_volta
	GuiControl,	,	_b_sai
	GuiControl,	,	_b_volta
	GuiControl,	,	_c_sai
	GuiControl,	,	_c_volta
	GuiControl,	,	_s_sai
	GuiControl,	,	_s_volta
	GuiControl,	,	_m_sai
	GuiControl,	,	_m_volta
	botao 			=		Registrar Retorno do Intervalo
	FormatTime,	saiu,	A_Now,	yyyy/MM/dd HH:mm:ss
	GuiControl,	,	_l_sai,	Saída: %saiu%
	atualiza		=
	(
		INSERT	INTO	[ASM].[Sistema_Monitoramento].[dbo].[Controle_Saidas]	([nome],[hora_saiu],[tipo])	VALUES	('%usuarioatual%',CONVERT(datetime,'%saiu%',121),'Intervalo')
	)
	atualiza		:= adosql(con,atualiza)
}
else
{
	GuiControl,	Disable,	_snack
	t1				=
	(
		SELECT	top(1) [id],[hora_saiu]	FROM	[ASM].[Sistema_Monitoramento].[dbo].[Controle_Saidas]	WHERE	[hora_retornou]	IS	NULL	AND [nome]	=	'%usuarioatual%' AND [tipo] = 'Intervalo'
	)
	t1				:=	adosql(con,t1)
	t					:=	StrSplit(SubStr(t1[2,2],12),":")
	segundos1	:=	(t[1]*60*60)+(t[2]*60)+t[3]
	FormatTime,	retorno,	A_Now,	yyyy/MM/dd HH:mm:ss
	z					:=	StrSplit(SubStr(retorno,12),":")
	segundos2	:=	(z[1]*60*60)+(z[2]*60)+z[3]
	passou		:=	segundos2 - segundos1
	if(passou<0)	{
		d1			:=	86400-segundos1
		passou	:=	d1+segundos2
	}
	tempo			:=	FormatSeconds(passou)
	GuiControl,	,	_l_volta,	Retorno: %retorno%
	t1				:=	t1[2,1]
	botao			= Registrar Saída Para Intervalo
	atualiza		=
	(
		UPDATE	[ASM].[Sistema_Monitoramento].[dbo].[Controle_Saidas]
		SET	[hora_retornou]	=	CONVERT(datetime,'%retorno%',121), [tempo_fora]	=	'%tempo%'
		WHERE	id	=	'%t1%'
	)
	atualiza		:= adosql(con,atualiza)
	;~ GuiControl,	Enable,	_market
	GuiControl,	Enable,	_bath
	;~ GuiControl,	Enable,	_coffee
	;~ GuiControl,	Enable,	_mate
}
Sleep,	2000
GuiControl,	Enable,	_snack
GuiControl,	,	_snack,	%botao%
return	;}
;~ _sair2:			;{	Café - Água
;~ coffee				:=	!coffee
;~ if(coffee=1)	{
	;~ GuiControl,	Disable,	_market
	;~ GuiControl,	Disable,	_bath
	;~ GuiControl,	Disable,	_mate
	;~ GuiControl,	Disable,	_snack
	;~ GuiControl,	,	_l_sai
	;~ GuiControl,	,	_l_volta
	;~ GuiControl,	,	_b_sai
	;~ GuiControl,	,	_b_volta
	;~ GuiControl,	,	_c_sai
	;~ GuiControl,	,	_c_volta
	;~ GuiControl,	,	_s_sai
	;~ GuiControl,	,	_s_volta
	;~ GuiControl,	,	_m_sai
	;~ GuiControl,	,	_m_volta
	;~ last				=
	;~ (
		;~ SELECT	[id]	FROM	[ASM].[Sistema_Monitoramento].[dbo].[Controle_Saidas]
		;~ WHERE	[nome]	=	'%usuarioatual%'
		;~ ORDER	BY	1	DESC
	;~ )
	;~ last				:=	adosql(con,last)
	;~ last				:=	last[2,1]
	;~ if(StrLen(last)=0)
		;~ last			=	0
	;~ last++
	;~ botao 			= Registrar Retorno do Café/Água
	;~ FormatTime,	saiu,	A_Now,	yyyy/MM/dd HH:mm:ss
	;~ GuiControl,	,	_c_sai,	Saída: %saiu%
	;~ atualiza		=
	;~ (
		;~ INSERT	INTO	[ASM].[Sistema_Monitoramento].[dbo].[Controle_Saidas]	([id],[nome],[hora_saiu],[tipo])	VALUES	('%last%','%usuarioatual%',CONVERT(datetime,'%saiu%',121),'Café/Água')
	;~ )
	;~ atualiza		:= adosql(con,atualiza)
;~ }
;~ else
;~ {
	;~ t1				=
	;~ (
		;~ SELECT	top(1) [id],[hora_saiu]	FROM	[ASM].[Sistema_Monitoramento].[dbo].[Controle_Saidas]	WHERE	[hora_retornou]	IS	NULL	AND [nome]	=	'%usuarioatual%' AND [tipo] = 'Café/Água'
	;~ )
	;~ t1				:=	adosql(con,t1)
	;~ t					:=	StrSplit(SubStr(t1[2,2],12),":")
	;~ segundos1	:=	(t[1]*60*60)+(t[2]*60)+t[3]
	;~ FormatTime,	retorno,	A_Now,	yyyy/MM/dd HH:mm:ss
	;~ z					:=	StrSplit(SubStr(retorno,12),":")
	;~ segundos2	:=	(z[1]*60*60)+(z[2]*60)+z[3]
	;~ passou		:=	segundos2 - segundos1
	;~ if(passou<0)	{
		;~ d1			:=	86400-segundos1
		;~ passou	:=	d1+segundos2
	;~ }
	;~ tempo			:=	FormatSeconds(passou)
	;~ GuiControl,	,	_c_volta,	Retorno: %retorno%
	;~ t1				:=	t1[2,1]
	;~ botao			= Registrar Saída Para Café
	;~ atualiza		=
	;~ (
		;~ UPDATE	[ASM].[Sistema_Monitoramento].[dbo].[Controle_Saidas]
		;~ SET	[hora_retornou]	=	CONVERT(datetime,'%retorno%',121), [tempo_fora]	=	'%tempo%'
		;~ WHERE	id	=	'%t1%'
	;~ )
	;~ atualiza		:= adosql(con,atualiza)
	;~ GuiControl,	Enable,	_market
	;~ GuiControl,	Enable,	_bath
	;~ GuiControl,	Enable,	_mate
	;~ GuiControl,	Enable,	_snack
;~ }
;~ GuiControl,	,	_coffee,	%botao%
;~ return	;}
_sair3:				;{	Banheiro
bath				:=	!bath
if(bath=1)	{
	GuiControl,	Disable,	_market
	GuiControl,	Disable,	_coffee
	GuiControl,	Disable,	_mate
	GuiControl,	Disable,	_snack
	GuiControl,	Disable,	_bath
	GuiControl,	,	_l_sai
	GuiControl,	,	_l_volta
	GuiControl,	,	_b_sai
	GuiControl,	,	_b_volta
	GuiControl,	,	_c_sai
	GuiControl,	,	_c_volta
	GuiControl,	,	_s_sai
	GuiControl,	,	_s_volta
	GuiControl,	,	_m_sai
	GuiControl,	,	_m_volta
	botao 			= Registrar Retorno do Banheiro
	FormatTime,	saiu,	A_Now,	yyyy/MM/dd HH:mm:ss
	GuiControl,	,	_b_sai,	Saída: %saiu%
	atualiza		=
	(
		INSERT	INTO	[ASM].[Sistema_Monitoramento].[dbo].[Controle_Saidas]	([nome],[hora_saiu],[tipo])	VALUES	('%usuarioatual%',CONVERT(datetime,'%saiu%',121),'Banheiro')
	)
	atualiza		:= adosql(con,atualiza)
}
else
{
	GuiControl,	Disable,	_bath
	t1				=
	(
		SELECT	top(1) [id],[hora_saiu]	FROM	[ASM].[Sistema_Monitoramento].[dbo].[Controle_Saidas]	WHERE	[hora_retornou]	IS	NULL	AND [nome]	=	'%usuarioatual%' AND [tipo] = 'Banheiro'
	)
	t1				:=	adosql(con,t1)
	t					:=	StrSplit(SubStr(t1[2,2],12),":")
	segundos1	:=	(t[1]*60*60)+(t[2]*60)+t[3]
	FormatTime,	retorno,	A_Now,	yyyy/MM/dd HH:mm:ss
	z					:=	StrSplit(SubStr(retorno,12),":")
	segundos2	:=	(z[1]*60*60)+(z[2]*60)+z[3]
	passou		:=	segundos2 - segundos1
	if(passou<0)	{
		d1			:=	86400-segundos1
		passou	:=	d1+segundos2
	}
	tempo			:=	FormatSeconds(passou)
	GuiControl,	,	_b_volta,	Retorno: %retorno%
	t1				:=	t1[2,1]
	botao 			= Registrar Saída Para Banheiro
	atualiza		=
	(
		UPDATE	[ASM].[Sistema_Monitoramento].[dbo].[Controle_Saidas]
		SET	[hora_retornou]	=	CONVERT(datetime,'%retorno%',121), [tempo_fora]	=	'%tempo%'
		WHERE	id	=	'%t1%'
	)
	atualiza		:= adosql(con,atualiza)
	GuiControl,	Enable,	_market
	GuiControl,	Enable,	_coffee
	GuiControl,	Enable,	_mate
	GuiControl,	Enable,	_snack
}
Sleep,	2000
GuiControl,	Enable,	_bath
GuiControl,	,	_bath,	%botao%
return	;}
_sair4:				;{	Mercado
market			:=	!market
if(market=1)	{
	GuiControl,	Disable,	_coffee
	GuiControl,	Disable,	_bath
	GuiControl,	Disable,	_mate
	GuiControl,	Disable,	_market
	GuiControl,	Disable,	_snack
	GuiControl,	,	_l_sai
	GuiControl,	,	_l_volta
	GuiControl,	,	_b_sai
	GuiControl,	,	_b_volta
	GuiControl,	,	_c_sai
	GuiControl,	,	_c_volta
	GuiControl,	,	_s_sai
	GuiControl,	,	_s_volta
	GuiControl,	,	_m_sai
	GuiControl,	,	_m_volta
	botao 			= Registrar Retorno do Supermercado
	FormatTime,	saiu,	A_Now,	yyyy/MM/dd HH:mm:ss
	GuiControl,	,	_s_sai,	Saída: %saiu%
	atualiza		=
	(
		INSERT	INTO	[ASM].[Sistema_Monitoramento].[dbo].[Controle_Saidas]	([nome],[hora_saiu],[tipo])	VALUES	('%usuarioatual%',CONVERT(datetime,'%saiu%',121),'Supermercado')
	)
	atualiza		:= adosql(con,atualiza)
}
else
{
	t1				=
	(
		SELECT	top(1) [id],[hora_saiu]	FROM	[ASM].[Sistema_Monitoramento].[dbo].[Controle_Saidas]	WHERE	[hora_retornou]	IS	NULL	AND [nome]	=	'%usuarioatual%' AND [tipo] = 'Supermercado'
	)
	t1				:=	adosql(con,t1)
	t					:=	StrSplit(SubStr(t1[2,2],12),":")
	segundos1	:=	(t[1]*60*60)+(t[2]*60)+t[3]
	FormatTime,	retorno,	A_Now,	yyyy/MM/dd HH:mm:ss
	z					:=	StrSplit(SubStr(retorno,12),":")
	segundos2	:=	(z[1]*60*60)+(z[2]*60)+z[3]
	passou		:=	segundos2 - segundos1
	if(passou<0)	{
		d1			:=	86400-segundos1
		passou	:=	d1+segundos2
	}
	tempo			:=	FormatSeconds(passou)
	GuiControl,	,	_s_volta,	Retorno: %retorno%
	t1				:=	t1[2,1]
	botao			= Registrar Saída Para Supermercado
	atualiza		=
	(
		UPDATE	[ASM].[Sistema_Monitoramento].[dbo].[Controle_Saidas]
		SET	[hora_retornou]	=	CONVERT(datetime,'%retorno%',121), [tempo_fora]	=	'%tempo%'
		WHERE	id	=	'%t1%'
	)
	atualiza		:= adosql(con,atualiza)
	GuiControl,	Enable,	_coffee
	GuiControl,	Enable,	_bath
	GuiControl,	Enable,	_mate
	GuiControl,	Enable,	_snack
}
GuiControl,	,	_market,	%botao%
return	;}
_sair5:				;{	Chimarrão
mate				:=	!mate
if(mate=1)	{
	GuiControl,	Disable,	_market
	GuiControl,	Disable,	_bath
	GuiControl,	Disable,	_coffee
	GuiControl,	Disable,	_snack
	GuiControl,	Disable,	_mate
	GuiControl,	,	_l_sai
	GuiControl,	,	_l_volta
	GuiControl,	,	_b_sai
	GuiControl,	,	_b_volta
	GuiControl,	,	_c_sai
	GuiControl,	,	_c_volta
	GuiControl,	,	_s_sai
	GuiControl,	,	_s_volta
	GuiControl,	,	_m_sai
	GuiControl,	,	_m_volta
	botao			 = Registrar Retorno do Chimarrão
	FormatTime,	saiu,	A_Now,	yyyy/MM/dd HH:mm:ss
	GuiControl,	,	_m_sai,	Saída: %saiu%
	atualiza		=
	(
		INSERT	INTO	[ASM].[Sistema_Monitoramento].[dbo].[Controle_Saidas]	([nome],[hora_saiu],[tipo])	VALUES	('%usuarioatual%',CONVERT(datetime,'%saiu%',121),'Chimarrão')
	)
	atualiza		:= adosql(con,atualiza)
}
else
{
	t1				=
	(
		SELECT	top(1) [id],[hora_saiu]	FROM	[ASM].[Sistema_Monitoramento].[dbo].[Controle_Saidas]	WHERE	[hora_retornou]	IS	NULL	AND [nome]	=	'%usuarioatual%' AND [tipo] = 'Chimarrão'
	)
	t1				:=	adosql(con,t1)
	t					:=	StrSplit(SubStr(t1[2,2],12),":")
	segundos1	:=	(t[1]*60*60)+(t[2]*60)+t[3]
	FormatTime,		retorno,	A_Now,	yyyy/MM/dd HH:mm:ss
	z					:=	StrSplit(SubStr(retorno,12),":")
	segundos2	:=	(z[1]*60*60)+(z[2]*60)+z[3]
	passou		:=	segundos2 - segundos1
	if(passou<0)	{
		d1			:=	86400-segundos1
		passou	:=	d1+segundos2
	}
	tempo			:=	FormatSeconds(passou)
	GuiControl,	,	_m_volta,	Retorno: %retorno%
	t1				:=	t1[2,1]
	botao 			=		Registrar Saída Para Chimarrão
	atualiza		=
	(
		UPDATE	[ASM].[Sistema_Monitoramento].[dbo].[Controle_Saidas]
		SET	[hora_retornou]	=	CONVERT(datetime,'%retorno%',121), [tempo_fora]	=	'%tempo%'
		WHERE	id	=	'%t1%'
	)
	atualiza		:= adosql(con,atualiza)
	GuiControl,	Enable,	_market
	GuiControl,	Enable,	_bath
	GuiControl,	Enable,	_coffee
	GuiControl,	Enable,	_snack
}
GuiControl,	,	_mate,	%botao%
return	;}
verifica:			;{
if(usuarioatual="DSANTOS")
	usuarioatual	=	DIEISSON
if(usuarioatual="CMATOS")
	usuarioatual	=	CRISTIANO
if(usuarioatual="DDIEL")
	usuarioatual	=	DJEISON
if(usuarioatual="ARSILVA")
	usuarioatual	=	ANDERSON
	h_null	=
	(
		SELECT	TOP(1)	*	FROM	[ASM].[Sistema_Monitoramento].[dbo].[Controle_Saidas]	WHERE	nome	=	'%usuarioatual%'	ORDER BY	1	DESC
	)
	h_null	:=	adosql(con,h_null)
	hsaiu	:=	h_null[2,3]
	if(StrLen(h_null[2,4])=0	AND	h_null[2,6]="Intervalo")			{
		botao 			=	Registrar Retorno do Intervalo
		GuiControl,	,	_snack,	%botao%
		GuiControl,	Disable,	_bath
		GuiControl,	,	_l_sai,	Saída: %hsaiu%
		GuiControl,	,	_l_volta
		GuiControl,	,	_b_sai
		GuiControl,	,	_b_volta
		snack	=	1
	}
	if(StrLen(h_null[2,4])=0	AND	h_null[2,6]="Banheiro")			{
		botao 			=	Registrar Retorno do Banheiro
		GuiControl,	,	_bath,	%botao%
		GuiControl,	Disable,	_snack
		GuiControl,	,	_l_sai
		GuiControl,	,	_l_volta
		GuiControl,	,	_b_sai,	Saída: %hsaiu%
		GuiControl,	,	_b_volta
		bath	=	1
	}	;}
	;~ if(StrLen(h_null[2,4])=0	AND	h_null[2,6]="Chimarrão")		{	;{
		;~ botao 			=	Registrar Retorno do Chimarrão
		;~ GuiControl,	,	_mate,	%botao%
		;~ GuiControl,	Disable,	_coffee
		;~ GuiControl,	Disable,	_bath
		;~ GuiControl,	Disable,	_market
		;~ GuiControl,	Disable,	_snack
		;~ GuiControl,	,	_l_sai
		;~ GuiControl,	,	_l_volta
		;~ GuiControl,	,	_b_sai
		;~ GuiControl,	,	_b_volta
		;~ GuiControl,	,	_c_sai
		;~ GuiControl,	,	_c_volta
		;~ GuiControl,	,	_s_sai
		;~ GuiControl,	,	_s_volta
		;~ GuiControl,	,	_m_sai,	Saída: %hsaiu%
		;~ GuiControl,	,	_m_volta
		;~ mate	=	1
	;~ }	;}
	;~ if(StrLen(h_null[2,4])=0	AND	h_null[2,6]="Supermercado")	{	;{
		;~ botao 			=	Registrar Retorno do Supermercado
		;~ GuiControl,	,	_market,	%botao%
		;~ GuiControl,	Disable,	_mate
		;~ GuiControl,	Disable,	_bath
		;~ GuiControl,	Disable,	_coffee
		;~ GuiControl,	Disable,	_snack
		;~ GuiControl,	,	_l_sai
		;~ GuiControl,	,	_l_volta
		;~ GuiControl,	,	_b_sai
		;~ GuiControl,	,	_b_volta
		;~ GuiControl,	,	_c_sai
		;~ GuiControl,	,	_c_volta
		;~ GuiControl,	,	_s_sai,	Saída: %hsaiu%
		;~ GuiControl,	,	_s_volta
		;~ GuiControl,	,	_m_sai
		;~ GuiControl,	,	_m_volta
		;~ market	=	1
	;~ }
return
;}
;}
Checagem:												;{
	u			=	;	user logado
	(
		SELECT	TOP(1)	[LOG~USUARIO],[LOG~ORDEM]
		FROM	[BdIrisLog].[dbo].[SYS~Log]
		WHERE	[LOG~DADOS]	=	'Login no Painel de Monitoramento.'
		AND	[LOG~ESTACAO]	=	'%A_ComputerName%'
		ORDER	BY	2	DESC
	)
	u	:=	adosql(con,u)
	usuarioa	:=	u[2,1]
	;{	usuarios admins e normais
	if(usuarioatual="cmatos"	AND	usuarioa="cristiano")
		return
	if(usuarioatual="dsantos"	AND	usuarioa="dieisson")
		return
	if(usuarioatual="arsilva"	AND	usuarioa="anderson")
		return
	if(usuarioatual="ddiel"	AND	usuarioa="djeison")
		return
	if(usuarioa="cmatos"	AND	usuarioatual="cristiano")
		return
	if(usuarioa="dsantos"	AND	usuarioatual="dieisson")
		return
	if(usuarioa="arsilva"	AND	usuarioatual="anderson")
		return
	if(usuarioa="ddiel"	AND	usuarioatual="djeison")
		return	;}
	if(usuarioa!=usuarioatual)	;{	Se mudou o usuário, reinicia
		if(A_UserName="alberto")
			return
		else
			Reload
	return	;}
;}
FormatSeconds(NumberOfSeconds)	{
	time	=	19990101
	time	+=	%NumberOfSeconds%,	seconds
	FormatTime,	mmss,	%time%,	mm:ss
	return	NumberOfSeconds//3600	":"	mmss  ; This method is used to support more than 24 hours worth of sections.
}
gerar:														;{
Gui,	relatorio:Submit,	NoHide
if(r1=1)	;{
	radio	=	2
if(r2=1)
	radio	=	3
if(r3=1)
	radio	=	5
if(r4=1)
	radio	=	6
if(r1=0 and r2=0 and r3=0 and r4=0)
	radio = 1	;}
if(operador!="")	{	;	Contém filtro por nome
	reg	=	
	(
		SELECT [login],[login2] FROM [ASM].[Sistema_Monitoramento].[dbo].[Operadores]	WHERE nome = '%operador%'
	)
	reg	:=	adosql(con,reg)
	res1	:=	StrReplace(reg[2,1],"`r`n")
	res2	:=	StrReplace(reg[2,2],"`r`n")
}
if(StrLen(operador)>0)	{
	operador	:=	StrReplace(operador,"`r`n")
	if(StrLen(res2)=0)
		q1				=	AND nome = '%res1%'
	else
		q1				=	AND (nome = '%res1%' OR nome = '%res2%')
}
else
{
	q1	=
	operador	=	
}
if(StrLen(motivo)>0)	{
	q2				=	AND tipo = '%motivo%'
	motivo		= pelo motivo `"%motivo%`"
}
else
{
	q2	=
	motivo	=	
}
d_inicio	:=	SubStr(d_inicio,1,8)
d_final	:=	SubStr(d_final,1,8)
if(d_inicio<=d_final)	{
	FormatTime,	hoje,			%A_Now%,	yyy-MM-dd
	FormatTime,	year,			%A_Now%,	yyy
	FormatTime,	month,		%A_Now%,	MM
	FormatTime,	day,				%A_Now%,	dd
	FormatTime,	d_inicio1,	%d_inicio%,	yyy-MM-dd
	FormatTime,	d_final1,		%d_final%,		yyy-MM-dd
	if(d_inicio=d_final)	{
		data			=	no dia	`"%d_inicio1%`".
		q					=	(DATEPART(YEAR,hora_saiu)=%year% and DATEPART(MONTH,hora_saiu)=%month% and DATEPART(DAY,hora_saiu)=%day%) 
	}
	else
	{
		data			=	no período de `"%d_inicio1%`" a `"%d_final1%`"
		q					=	hora_saiu >=  '%d_inicio%'	and hora_saiu <= DATEADD(DD,1,'%d_final%')
	}
}
else
{
	MsgBox	A data FINAL não pode ser INFERIOR a data INICIAL.
	return
}
if(StrLen(operador)=0)
	texto	:=	"Consulta buscando dados:`n`n" motivo "`n" data
if(StrLen(motivo)=0)
	texto	:=	"Consulta buscando dados:`n`n" operador "`n" data
if(StrLen(motivo)=0	and StrLen(operador)=0)
	texto	:=	"Consulta buscando dados:`n`n" data
if(StrLen(motivo)!=0 and StrLen(operador)!=0)
	texto	:=	"Consulta buscando dados:`n`n" operador "`n" motivo "`n" data
GuiControl,	relatorio:,	query,	%texto%
sql_r	=	
(
	SELECT *	FROM	[ASM].[Sistema_Monitoramento].[dbo].[Controle_Saidas]	WHERE	%q%	%q1%	%q2% ORDER BY %radio%
)
sql_r				:=	adosql(con,sql_r)
r	=
Gosub CreateNewCalc
IfWinExist,	Relatório de erros
	WinClose,	Relatório de erros
oSheet			:=	oSheets.getByIndex(0)
if(StrLen(operador)=0)
	operador	:=	"Todos - " d_inicio " a " d_final ".csv"
sPath				:=	A_Desktop
sFileName		=		Controle Horarios %operador%.ods
SheetName	:=	oSheets.getByIndex(0).Name
;{	CALC properties
Column = A	;{
oColumns := oSheet.getColumns()
oColumn := oColumns.getByName( Column )
oColumn.Width := 3000	;}
Column = B	;{
oColumns := oSheet.getColumns()
oColumn := oColumns.getByName( Column )
oColumn.Width := 4000	;}
Column = C	;{
oColumns := oSheet.getColumns()
oColumn := oColumns.getByName( Column )
oColumn.Width := 4000	;}
Column = D	;{
oColumns := oSheet.getColumns()
oColumn := oColumns.getByName( Column )
oColumn.Width := 3000	;}
Column = E	;{
oColumns := oSheet.getColumns()
oColumn := oColumns.getByName( Column )
oColumn.Width := 3000	;}
;}

nFormat := oFormats.getStandardFormat( "4", oLocale )	; com.sun.star.util.NumberFormat.CURRENCY
Loop,	%	sql_r.MaxIndex()
{
	if(A_Index=1)	{
		oCell := oSheet.getCellRangeByName( "A"A_Index )
		oCell.setString("Nome")
		oCell := oSheet.getCellRangeByName( "B"A_Index )
		oCell.setString("Horário de Saída")
		oCell := oSheet.getCellRangeByName( "C"A_Index )
		oCell.setString("Horário de Retorno")
		oCell := oSheet.getCellRangeByName( "D"A_Index )
		oCell.setString("Tempo Fora")
		oCell := oSheet.getCellRangeByName( "E"A_Index )
		oCell.setString("Tipo de Saída")
	}
	else
	{
		oCell := oSheet.getCellRangeByName( "A"A_Index )
		oCell.setString(sql_r[A_Index,2])	
		oCell := oSheet.getCellRangeByName( "B"A_Index )
		oCell.setString(sql_r[A_Index,3])	
		oCell := oSheet.getCellRangeByName( "C"A_Index )
		oCell.setString(sql_r[A_Index,4])	
		oCell := oSheet.getCellRangeByName( "D"A_Index )
		oCell.setString(sql_r[A_Index,5])	;}	
		
		;{	segundos do dia
		;~ sd	:=	StrSplit(sql_r[A_Index,5],":")
		;~ segundos	:=	(sd[1]*60*60)+sd[2]*60+sd[3]
		;~ tempododia	:=	1/86400*segundos
		;~ oCell := oSheet.getCellRangeByName( "F"A_Index )
		;~ oCell.setString(tempododia)
		oCell.NumberFormat := nFormat
		oCell := oSheet.getCellRangeByName( "E"A_Index )
		oCell.setString(sql_r[A_Index,6])	
	}
	oCell := oSheet.getCellRangeByName( "D" sql_R.MaxIndex()+1 )
	oCell.NumberFormat := nFormat
	;~ oSheet.getCellByPosition( 3, sql_r.MaxIndex()+1 ).setFormula( "=SUM(F2:F"	sql_r.MaxIndex()	")" )
}

If !sPath
	sPath			:=	A_Desktop
If !( SubStr(sPath, StrLen(sPath)-1, 1) = "\" )
	sPath := sPath "\"
FileNameOut := sPath sFileName
If	FileExist( FileNameOut )
	FileDelete %FileNameOut%
oDoc.storeAsURL(FileURL(FileNameOut), Array)

oDoc.Close(True)
oDoc := ""
IfWinExist,	Recuperação de documentos
	WinClose,	Recuperação de documentos
IfWinExist,	Relatório de erros
	WinClose,	Relatório de erros
MsgBox, 4,, Gostaria de abrir o arquivo?`n	%FileNameOut%
IfMsgBox Yes
	Run,	%FileNameOut%
IfWinExist,	Recuperação de documentos
	WinClose,	Recuperação de documentos
Sleep,	2000
IfWinExist,	Relatório de erros
	WinClose,	Relatório de erros
	;}
relatorioGuiClose:									;{
Gui,	relatorio:Destroy
return	;}
novo_email:												;{
nm	=
(
	SELECT TOP(1)	p.IdCliente, p.QuandoAvisar, p.Mensagem, p.Assunto, c.Nome,	p.Idaviso
	FROM [IrisSQL].[dbo].[Agenda] p
	LEFT JOIN [IrisSQL].[dbo].[Clientes] c ON p.IdCliente = c.IdUnico
	WHERE CONVERT(VARCHAR(25), Quandoavisar, 126) like '%data%`%'
	ORDER BY 6 DESC
	)
	nm	:=	adosql(con,nm)
	if(last_id<nm[2,6])	{
	subjm	:=	nm[2,4]
	iadaviso	:=	nm[2,6]
	IfInString,	subjm,	Informou
	{
		deleta	=
		(
			DELETE	FROM	[IrisSQL].[dbo].[Agenda]
			WHERE	idaviso	=	'%iadaviso%'
		)
		if(ip4=184)
			deleta	:=	adosql(con,deleta)
		return
	}
		last_id	:=	nm[2,6]
		TrayTip,	NOVO E-MAIL, %	nm[2,3] "`n`t"	nm[2,5]
		;~ SoundPlay, %smk%car.wav
		gosub	carrega_lv
	}
return	;}
;{	SALVAR  NO CALC
CreateNewCalc:	;{
	oSM						:=	ComObjCreate("com.sun.star.ServiceManager")					;	This line is mandatory with AHK for OOo API
	oDesk						:=	oSM.createInstance("com.sun.star.frame.Desktop")			;	Create the first and most important service
	Array						:=	ComObjArray(VT_VARIANT:=12, 2)
	Array[1]					:=	MakePropertyValue(oSM, "hidden", ComObject(0xB,true))
	sURL						:=	"private:factory/scalc"
	oDoc						:=	oDesk.loadComponentFromURL(sURL, "_blank", 0, Array)
	oBorder					:=	oSM.Bridge_GetStruct("com.sun.star.table.BorderLine")
	oSheets					:=	oDoc.getSheets()
	SheetName			:=	oSheets.getByIndex(0).Name
	oFormats				:=	oDoc.getNumberFormats()
	oLocale					:=	oSM.Bridge_GetStruct("com.sun.star.lang.Locale")
	oLocale.Language	:=	"br"
	oLocale.Country	:=	"BR"
Return	;}
MakePropertyValue(oSM, cName, uValue)	{	
	oPropertyValue					:=	oSM.Bridge_GetStruct("com.sun.star.beans.PropertyValue")
	If	cName
		oPropertyValue.Name	:=	cName
	If	uValue
		oPropertyValue.Value	:=	uValue
	Return	oPropertyValue
}
FileURL( File )	{
	Local v, INTERNET_MAX_URL_LENGTH := 2048   
	VarSetCapacity(v,4200,0)
	DllCall( "Shlwapi.dll" ( SubStr(File,1,5)="file:" ? "\PathCreateFromUrl" : "\UrlCreateFromPath" )
			, "Str",File, "Str",v, "UIntP",INTERNET_MAX_URL_LENGTH, "UInt",0 )
	Return v
}
;}