GuiControl,	,	Loader,	Verificando Banco de Dados ativo
Sleep	250
;{ conexões
reescan:
if(StrLen(con)=0)	{
		con	:=	"Driver={SQL Server Native Client 10.0};Server=srvvdm-bd\iris10db;Uid=ahk;Pwd=139565Sa"
		conectado	=	Conectado ao BD ASM
}
if(refaz=1)	{
	refaz=
	return
}
GuiControl,	,	Loader,	Verificando Bando de Dados Oracle
if(StrLen(ora)=0)	{
	if(Ping("10.0.20.10")=0)	{
		MsgBox	Servidor ORACLE da cotrijal não está acessível.
	}
	else
		ora	:=	"Driver={Oracle in ora_moni};dbq=(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=oraprod)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=prod)));Uid=cotrijal;Pwd=infod01"
}
;}
GuiControl,	,	Loader,	Carregando Drivers ODBC
Global ADOSQL_LE, ADOSQL_LQ
ADOSQL( Connection_String, Query_Statement ) {
	coer := "", txtout := 0, rd := "`n", cd := "CSV", str := Connection_String
	If ( 9 < oTbl := 9 + InStr( ";" str, ";RowDelim=" ) )
	{
		rd := SubStr( str, oTbl, 0 - oTbl + oRow := InStr( str ";", ";", 0, oTbl ) )
		str := SubStr( str, 1, oTbl - 11 ) SubStr( str, oRow )
		txtout := 1
	}
	If ( 9 < oTbl := 9 + InStr( ";" str, ";ColDelim=" ) )
	{
		cd := SubStr( str, oTbl, 0 - oTbl + oRow := InStr( str ";", ";", 0, oTbl ) )
		str := SubStr( str, 1, oTbl - 11 ) SubStr( str, oRow )
		txtout := 1
	}

	ComObjError( 0 )
	If !( oCon := ComObjCreate( "ADODB.Connection" ) )
		Return "", ComObjError( 1 ), ErrorLevel := "Error"
		, ADOSQL_LE := "Fatal Error: ADODB is not available."
	oCon.ConnectionTimeout := 9
	oCon.CursorLocation := 3
	oCon.CommandTimeout := 1800
	oCon.Open( str )
	If !( coer := A_LastError )
		oRec := oCon.execute( ADOSQL_LQ := Query_Statement )
	If !( coer := A_LastError )
	{
		o3DA := []
		While IsObject( oRec )
			If !oRec.State 
				oRec := oRec.NextRecordset()
			Else
			{
				oFld := oRec.Fields
				o3DA.Insert( oTbl := [] )
				oTbl.Insert( oRow := [] )
				Loop % cols := oFld.Count
					oRow[ A_Index ] := oFld.Item( A_Index - 1 ).Name
				While !oRec.EOF
				{
					oTbl.Insert( oRow := [] )
					oRow.SetCapacity( cols )
					Loop % cols
						oRow[ A_Index ] := oFld.Item( A_Index - 1 ).Value	
					oRec.MoveNext()
				}
				oRec := oRec.NextRecordset()
			}
		If (txtout)
		{
			Query_Statement := "x"
			Loop % o3DA.MaxIndex()
			{
				Query_Statement .= rd rd
				oTbl := o3DA[ A_Index ]
				Loop % oTbl.MaxIndex()
				{
					oRow := oTbl[ A_Index ]
					Loop % oRow.MaxIndex()
						If ( cd = "CSV" )
						{
							str := oRow[ A_Index ]
							StringReplace, str, str, ", "", A
							If !ErrorLevel || InStr( str, "," ) || InStr( str, rd )
								str := """" str """"
							Query_Statement .= ( A_Index = 1 ? rd : "," ) str
						}
						Else
							Query_Statement .= ( A_Index = 1 ? rd : cd ) oRow[ A_Index ]
				}
			}
			Query_Statement := SubStr( Query_Statement, 2 + 3 * StrLen( rd ) )
		}
	}
	Else
	{
		oErr := oCon.Errors
		Query_Statement := "x"
		Loop % oErr.Count
		{
			oFld := oErr.Item( A_Index - 1 )
			str := oFld.Description
			Query_Statement .= "`n`n" SubStr( str, 1 + InStr( str, "]", 0, 2 + InStr( str, "][", 0, 0 ) ) )
				. "`n   Number: " oFld.Number
				. ", NativeError: " oFld.NativeError
				. ", Source: " oFld.Source
				. ", SQLState: " oFld.SQLState
		}
		ADOSQL_LE := SubStr( Query_Statement, 4 )
		Query_Statement := ""
		txtout := 1
	}
	oCon.Close()
	ComObjError( 1 )
	ErrorLevel := coer
	Return txtout ? Query_Statement : o3DA.MaxIndex() = 1 ? o3DA[1] : o3DA
}