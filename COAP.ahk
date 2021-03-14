SetTitleMatchMode, REGEX

Config(ScriptName){
    if (ScriptName = "F6 Microsoft SQL Server Management Studio") { 
		return 1
	}
	if (ScriptName = "CTRL+S Microsoft SQL Server Management Studio") {
		return 1
	}
	if (ScriptName = "DOUBLE LBUTTON Microsoft Visual Studio") {
		return 1
	}
}


;##################################################################################################### 
	#If Config("F6 Microsoft SQL Server Management Studio") and WinActive("Microsoft SQL Server Management Studio$")
	F6::
		ClipboardOld := CopyAllToClipboardAndReturnOld() 	
		if CountInString( Clipboard , "PROCEDURE" ) > 1 {
			MsgBox, Too many PROCEDURE, cant replace.
			return
		}
		Clipboard := StrReplace(Clipboard, "CREATE PROCEDURE", "CREATE OR ALTER PROCEDURE",0,1)
		Send ^v
		Send ^{Home}
		Clipboard := ClipboardOld 
	return
	;------------------------------------------------------------------------------------------------
	#If Config("CTRL+S Microsoft SQL Server Management Studio") and WinActive("Microsoft SQL Server Management Studio$")
	^s::
		ClipboardOld := CopyAllToClipboardAndReturnOld() 
		if CountInString( Clipboard , "PROCEDURE" ) > 1 {
			MsgBox, Too many PROCEDURE. Saved without replace anyway.
			Send ^{Home}
			Send ^s
			return
		}
		Clipboard := StrReplace(Clipboard, "CREATE OR ALTER PROCEDURE", "CREATE PROCEDURE",0,1)
		Send ^v
		Send ^{Home}
		Send ^s
		Clipboard := ClipboardOld
	return
	;------------------------------------------------------------------------------------------------
	#If Config("DOUBLE LBUTTON Microsoft Visual Studio") and ClickedOnWindow("Microsoft Visual Studio$")  
	~LButton::
		If (A_ThisHotkey = A_PriorHotkey and A_TimeSincePriorHotkey < 500 ) {
			WinWaitActive, Microsoft SQL Server Management Studio$ ,, 5
			if ErrorLevel {
				return
			}
			ClipboardOld := CopyAllToClipboardAndReturnOld() 	
			if CountInString( Clipboard , "PROCEDURE" ) > 1 {
				MsgBox, Too many PROCEDURE, cant replace.
				return
			}
			Clipboard := StrReplace(Clipboard, "CREATE PROCEDURE", "CREATE OR ALTER PROCEDURE",0,3)
			Send ^v
			Send ^{Home}
			Clipboard := ClipboardOld 
		}
	Return
;#####################################################################################################



;-------------------------------Functions-------------------------------------------------------------
;#####################################################################################################
ClickedOnWindow(wintitle) {
	local wum
	mousegetpos,,,wum
	if winExist(wintitle) == wum
		return 1
	return 0
}
;------------------------------------------------------------------------------------------------
CountInString( ByRef Haystack , Needle = "" ) {
	StringReplace, Haystack, Haystack, %Needle%, %Needle%, UseErrorLevel
	Return ErrorLevel
}
;------------------------------------------------------------------------------------------------
CopyAllToClipboardAndReturnOld(){ 
	ClipboardOld := Clipboard
	Clipboard := 
	Send ^a
	Send ^c
	ClipWait, 2
	if ErrorLevel
	{
		MsgBox, The attempt to copy text onto the clipboard failed.

	}
	Return ClipboardOld
}
;#####################################################################################################
