#Include	..\Libs\_gdip_all.ahk
#Include	..\Libs\_strings.ahk
agora(horario="")										{
	if(strLen(horario)=0)
		agora	:=	st_insert("-",st_insert("-",st_insert(" ",st_insert(":",st_insert(":",A_now,13),11),9),7),5)
	else
		agora	:=	st_insert("-",st_insert("-",st_insert(" ",st_insert(":",st_insert(":",horario,13),11),9),7),5)
	return	agora
}

Accents(text)													{
replace=¡·¿‡¬‚AaAa√„????ƒ‰≈ÂAaAa??????????????????????CcCcCcCc«ÁDd–d–…È»Ë ÍEeEe????EeÀÎEeEe????????????GgGgGgGgHhHhÕÌÃÏIiŒÓIiœÔIiIiIi????JjKkLlLlLlLl??NnNn—ÒNn”Û“ÚOo‘Ù????????Oo÷ˆOo’ıÿ¯??Oo??Oo??????????????????RrRrRrSsSsäöSsTtTtTt⁄˙Ÿ˘Uu€˚UuUu‹¸UuUuUuUuUuUuUuUu??Uu????????????????Ww??›˝??Yyüˇ??????ZzéûZz
with=AaAaAaAaAaAaAaAaAaAaAaAaAaAaAaAaAaAaAaAaAaAaAaCcCcCcCcCcDdDdDEeEeEeEeEeEeEeEeEeEeEeEeEeEeEeEeEeGgGgGgGgHhHhIiIiIiIiIiIiIiIiIiIiIiJjKkLlLlLlLlLlNnNnNnNnOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoPpPpRrRrRrSsSsSsSsTtTtTtUuUuUuUuUuUuUuUuUuUuUuUuUuUuUuUuUuUuUuUuUuUuUuWwWwWwWwYyYyYyYyYyYyYyZzZzZz
Loop, Parse, Replace
   {
	stringmid, w, with, a_index, 1
	stringreplace, text, text, %a_loopfield%, %w%, All
   }
return text
}
BuscaSensor(nrSensor,	idCliente)				{
	if(StrLen(nrSensor)=1)
		nrSensor	:=	"0"	nrSensor
	if(StrLen(nrSensor)=3)
		nrSensor	:=	SubStr(nrSensor,	2,	2)
	zona := "E1300" nrSensor																;	zona para busca no banco do iris
	sensor   =																							;{	Busca a descriÁ„o dos sensores
	(
		SELECT
			[Descricao]
		FROM
			[IrisSQL].[dbo].[Alarmes]
		WHERE
			[Alarme]	=		'%zona%'	AND
			[IdCliente]	=	'%idCliente%'
	)
	sensor   :=  adosql(con,sensor)	;}
	nomeSensor := sensor[2,1]																;	DescriÁ„o do sensor
	if(StrLen(nomeSensor)=0)																;	Se o tamanho da descriÁ„o for 0, define o nome como n„o cadastrada
		nomeSensor	=	ZONA N√O CADASTRADA NO IRIS
	else
	{
		nmSensor	:=	StrSplit(nomeSensor," - ")
		nomeSensor2	:=	nmSensor[2]
		StringUpper, nomeSensor2, nomeSensor2, T							;	Define o texto como Title Case
		nomeSensor	:=	nmSensor[1]	" - "	nomeSensor2
	}
	zona    :=  StrReplace(zona,"E1300")												;	Remove do nome da zona o E1300
	return %nomeSensor%
}
ClickToCall(WTN)											{
	static req := ComObjCreate("Msxml2.XMLHTTP")
	req.open("GET", WTN, false)
	req.SetRequestHeader("Authorization", "Basic bW9uaXRvcmFtZW50bzpNMG4xMjBpNw==")
	req.send()
}

DateDiff(startT, endT)									{
	EnvSub, endT, startT, days
	return endT
}
Log(software, linha, problema)					{
	log_asm	=		INSERT INTO [ASM].[Logs].[dbo].[Log_ASM] (data,software,line,descricao) VALUES (current_timestamp,'%software%','%linha%','%problema%')
	log_asm	:=	adosql(con,log_asm)
}
LogMod(texto,nome)									{
	file		:= FileOpen("\\srvftp\Monitoramento\FTP\Log\"nome ".txt","a")
	texto	:=	texto . "`n"
	file.write(texto)
	file.close()
}
LogonUser(stuser, stpass)							{
	if DllCall("advapi32\LogonUser", "str", stuser, "str", "Cotrijal", "str", stpass, "Ptr", 3, "Ptr", 3, "UintP", nSize)
		ret	=	1
	else
		ret	=	0
	GuiControl, , user
	GuiControl, , pass
}

MaskName(altername)									{
	if altername = 
	SetEnv, semphone, 1
	StringUpper, altername, altername, T
	an	:=	StrSplit(altername, A_Space)
	Loop, % an.MaxIndex()
	{
	if	(	A_index	=	1	or	A_Index = an.MaxIndex()	)
	newname	:=	an[A_Index]
	else
	{
	if (	an[A_index]	=	"do"	or	an[A_index]	=	"da"	or	an[A_index]	=	"dos"	or	an[A_index]	=	"das"	or	an[A_index]	=	"de"	)
	{
	newname :=	an[A_Index]
	StringLower, newname, newname
	}
	else
	newname	:=	SubStr(an[A_Index],1,1) "."
	}
	nomeretorno	:=	nomeretorno . " " . newname " "
	}
	
    return %nomeretorno%
}
MaskCargo(cargo)										{
	if(cargo="")
		return
	cargo	:=	StrReplace(StrReplace(StrReplace(StrReplace(StrReplace(StrReplace(StrReplace(StrReplace(cargo,"COORDENADOR ","C. ")," UNIDADES")," UNIDADE"),"DE ")," UNIDANEGOCIOS")," NEGOCIOS"),"CENTRO DISTRIBUICAO","CD"),"DA ")
	StringUpper, cargo, cargo, T
    return %cargo%
}
MaskTel(telnum)											{
	if telnum =
	SetEnv, semphone, 1
	else
	SetEnv, semphone, 0
	IfInString, telnum, (
	{
	telnum	:=	strreplace(telnum,"(")
	telnum	:=	strreplace(telnum,")")
	telnum	:=	strreplace(telnum," ")
	telnum	:=	strreplace(telnum," ")
	telnum	:=	strreplace(telnum," ")
	telnum	:=	strreplace(telnum," ")
	telnum	:=	strreplace(telnum," ")
	telnum	:=	strreplace(telnum," ")
	}
	ddd	:=	SubStr(telnum,1,3)
	IfInString, ddd, 054
	telnum	:=	strreplace(telnum,"054","54")
	IfInString, ddd, 055
	telnum	:=	strreplace(telnum,"055","55")
	IfInString, ddd, 051
	telnum	:=	strreplace(telnum,"051","51")
	StringTrimRight, numeroa, telnum, 8
	StringTrimRight, numerob, telnum, 4
	StringLen, len, telnum
	if len = 11
	SetEnv, num, 7
	else
	SetEnv, num, 6
	if num = 7
	SetEnv, vb, 3
	if num = 6
	SetEnv, vb, 2
	StringTrimLeft, numerob, numerob, %vb%
	StringTrimLeft, numeroc, telnum, %num%
	if semphone = 0
	if vb = 2
	telnum = 0`( 0%numeroa% `) %numerob% - %numeroc%
	Else
	telnum = 0`(0%numeroa%`) %numerob% - %numeroc%
	SetEnv, semphone, 0
    return %telnum%
}
NovoEmail()													{
	nm	=	SELECT TOP(1) p.IdCliente, p.QuandoAvisar, p.Mensagem, p.Assunto, c.Nome,	p.Idaviso FROM [IrisSQL].[dbo].[Agenda] p LEFT JOIN [IrisSQL].[dbo].[Clientes] c ON p.IdCliente = c.IdUnico ORDER BY 6 DESC
	nm	:=	adosql(con,nm)
	if(StrLen(last_id)=0)	{
			last_id	:=	nm[2,1]
			return 0
	}
		
	if(last_id<nm[2,1])	{
	subjm	:=	nm[2,4]
	iadaviso	:=	nm[2,6]
	if(ip4=184)
		If(InStr(subjm,"Informou")>0)		{
			deleta	=	DELETE FROM	[IrisSQL].[dbo].[Agenda] WHERE idaviso = '%iadaviso%'
			deleta	:= adosql(con,deleta)
			return
		}
	last_id	:=	nm[2,6]
	TrayTip,	NOVO E-MAIL, %	nm[2,3] "`n`t"	nm[2,5]
	SoundPlay, %smk%car.wav
	}
return last_id
}
Ping(addr)														{
	if(addr="192.9.100.186" or addr="192.9.100.184" or addr="192.9.100.182" or addr="192.9.100.183")
		GuiControl,	,	Loader,	Verificando Banco de Dados ativo - Testando %addr%...
colPings := ComObjGet( "winmgmts:" ).ExecQuery("Select * From Win32_PingStatus where Address = '" addr "'")._NewEnum
	While colPings[objStatus]
		Return ((oS:=(objStatus.StatusCode="" or objStatus.StatusCode<>0)) ? "0" : "1")
}
ProcessExist(processo)									{
	Process,Exist,%processo%
	return Errorlevel
}
