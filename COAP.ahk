SetTitleMatchMode, REGEX

global F6_Microsoft_SQL_Server_Management_Studio = 1
global CTRL_S_Microsoft_SQL_Server_Management_Studio = 1
global DOUBLE_LBUTTON_Microsoft_Visual_Studio = 1


;##################################################################################################### 
#IfWinActive, Microsoft SQL Server Management Studio$
	;------------------------------------------------------------------------------------------------
	F6::
		if (F6_Microsoft_SQL_Server_Management_Studio){
			ClipboardOld := CopyAllToClipboardAndReturnOld() 	
			if CountInString( Clipboard , "PROCEDURE" ) > 1 {
				MsgBox, Too many PROCEDURE, cant replace.
				return
			}
			Clipboard := StrReplace(Clipboard, "CREATE PROCEDURE", "CREATE OR ALTER PROCEDURE",0,1)
			Send ^v
			Send ^{Home}
			Clipboard := ClipboardOld 
		}
	return
	;------------------------------------------------------------------------------------------------
	^s::
		if (CTRL_S_Microsoft_SQL_Server_Management_Studio){		
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
		}
	return
	;------------------------------------------------------------------------------------------------
#IfWinActive
;##################################################################################################### 

;##################################################################################################### 
#If ClickedOnWindow("Microsoft Visual Studio$")  
	~LButton::
		if (DOUBLE_LBUTTON_Microsoft_Visual_Studio){
			if (A_ThisHotkey = A_PriorHotkey and A_TimeSincePriorHotkey < 500 ) {
				WinWaitActive, Microsoft SQL Server Management Studio$ ,, 2
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
