SetTitleMatchMode, REGEX
#IfWinActive, Microsoft SQL Server Management Studio$


;#####################################################################################################
F7::
	ClipboardOld := CopyAllToClipboardAndReturnOld() 	
	if CountInString( Clipboard , "PROCEDURE" ) > 1
	{
		MsgBox, Too many PROCEDURE, cant replace.
		return
	}
	Clipboard := StrReplace(Clipboard, "CREATE PROCEDURE", "CREATE OR ALTER PROCEDURE",0,1)
	Send ^v
	Send ^{Home}
	Clipboard := ClipboardOld 
return
;#####################################################################################################

;#####################################################################################################
^s::
	ClipboardOld := CopyAllToClipboardAndReturnOld() 
	if CountInString( Clipboard , "PROCEDURE" ) > 1
	{
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
;#####################################################################################################



;-------------------------------Functions-------------------------------------------------------------

;#####################################################################################################
CountInString( ByRef Haystack , Needle = "" ) {
	StringReplace, Haystack, Haystack, %Needle%, %Needle%, UseErrorLevel
	Return ErrorLevel
}
;#####################################################################################################
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