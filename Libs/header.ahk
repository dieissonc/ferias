											GuiControl,	,	Loader,	Executando Header
											Sleep	250
FileEncoding,	UTF-8
#SingleInstance	Force
											GuiControl,	,	Loader,	Carregando Configurações
											Sleep	250
#Include	..\Libs\_configs.ahk
											GuiControl,	,	Loader,	Carregando Funções
											Sleep	250
#Include	..\Libs\_functions.ahk
#Include	..\Libs\_adosql.ahk
											ToolTip
if(A_UserName	=	"dsantos")
Menu,	Tray,	Icon
											GuiControl,	,	Loader,	Verificando versão do Sistema 
											Sleep	250
if(salvar=1)	{
	newc	=	;	REVER
	(
		IF EXISTS (SELECT * FROM [Sistema_Monitoramento].[dbo].[Versao e Update] WHERE ip='%ip%')
		UPDATE [ASM].[Sistema_Monitoramento].[dbo].[Versao e Update] SET [update] = 'nao', versao = '%version%', computador = '%A_ComputerName%' WHERE ip ='%ip%'
		ELSE
		INSERT INTO [ASM].[Sistema_Monitoramento].[dbo].[Versao e Update]
		VALUES ('%ip%','nao','%version%','%A_ComputerName%');

		IF EXISTS (SELECT * FROM [ASM].[Sistema_Monitoramento].[dbo].[Computadores] WHERE ip='%ip%')
		UPDATE [ASM].[Sistema_Monitoramento].[dbo].[Computadores] SET [maquina] = '%A_IPAddress1%', [nome] = '%A_ComputerName%' WHERE ip ='%ip%'
		ELSE
		INSERT INTO [ASM].[Sistema_Monitoramento].[dbo].[Computadores]
		VALUES ('%A_IPAddress1%','%A_ComputerName%','','%ip%');
	)
	newco	:= ADOSQL(con,newc)
	salvar	=
}

versao_	=	SELECT * FROM [ASM].[Sistema_Monitoramento].[dbo].[Versao e Update]
is_vers		:=	adosql(con,versao_)
Loop,	%	is_vers.MaxIndex()-1
{
	vers1	:=	 is_vers[A_Index+1,1]
	vers3	:=	 is_vers[A_Index+1,3]
	If(InStr(vers1,"255")>0)	{
		z				:=	StrSplit(vers3,".")
		codigo	:=	z[3]z[9]z[5]z[6]z[5]z[1]
	}
}
est	=	SELECT top 1 *	FROM [ASM].[Sistema_Monitoramento].[dbo].[Computadores]	where maquina = '%A_IPAddress1%'	order by 1 asc
esta := ADOSQL(con,est)
est				=
maquina		:=	esta[2,2]
oper			:=	esta[2,3]
inte				=		SELECT * FROM CAD_FUNCIONARIOS WHERE codigo = '%codigo%'
int				:=	adosql(ora,inte)
lib				:=	int[2,45]
lib2				:=	int[2,44]
if(debugging=2)	{
	lib	=	
	lib2	=	01/01/2020
}
if	lib is not digit
	ExitApp
if(lib=7	or lib="")	{
	if(lib="")	{
		MsgBox,48,Update Necessário,	Entre em contato com o desenvolvedor do sistema para o update do mesmo.`nLIB EMPTY
		ExitApp
	}
	lib2	:=	StrSplit(lib2,"/")
	lib2	:=	lib2[3] lib2[2] lib2[1]
	EnvSub, is_now, lib2,  days
	if(is_now>=30 and is_now<3650)	{
		MsgBox,48,Update Necessário,	Entre em contato com o desenvolvedor do sistema para o update do mesmo.`nLIB2 EXCEED VALUE
		ExitApp
	}
}
adosql_lq	=