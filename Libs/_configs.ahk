separador			=				`n-----------------------------------------------------------------`n`n
estacoes				=				162,166,169,176,179,184	;Inserir no banco de dados
FormatTime,		is_now,	A_Now,	yyyMMdd
SysGet,				m2,			MonitorWorkArea
SysGet,				m1,			Monitor
m_h						:=			m2Bottom
m_w					:=			m2Right
taskbar				:=			m1Bottom-m_h
isoff 					=				0
SetBatchLines,					-1
StringSplit,			ip,			A_IPAddress1,	.
ip 						:=			ip4								;VERIFICAR NECESSIDADE
smk						=				\\fs\Departamentos\monitoramento\Monitoramento\Dieisson\SMK\
logs						=				\\fs\Departamentos\monitoramento\Monitoramento\Dieisson\Logs\
motion				=				\\srvftp\Monitoramento\FTP\Motion\
light					:=			0xC9FFF8				;	Azul Claro
gray					:=			0x99A3A4				;	Cinza
lemon					:=			0xB2F4B1				;	Verde Claro
orange				:=			0xff9c38					;	Laranja Claro
green					:=			0x87BA86				;	Verde
;~ green					:=			0x30A32E				;	Verde
yellow					:=			0xEAFF63				;	Amarelo	Claro
red						:=			0xE82E2E				;	Vermelho
cyan					:=			0x75A5FF				;	Ciano
black					:=			0x000000				;	Preto
white					:=			0xFFFFFF				;	branco
operador1			=				CPC027893
operador2			=				CPC027896
operador3			=				CPC027897
operador4			=				CPC023409
operador5			=				CPC023405
bgctrl					=				dbdbdb	;	Fundo controles
bggui					=				425942	;	Fundo GUI
bglv					=				22AA8D	;	texto
segundoreset		=				0
minutoreset		=				1
horareset1			=				07
horareset2			=				19
global	cliptext,	istest,	con,	asm,	ora,	nomeSensor,	nrSensor,	forReplace,	m1,	m2,	m3,	ramal,	clicado,	user,	pass,	ret,	logs,	debug,	x,	camid,	nomedacamera,	id,	menufeito,	last_id,	debugando