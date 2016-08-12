#cs ----------------------------------------------------------------------------

	AutoIt Version: 3.3.12.0
	Author:         myName

	Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------
#include <File.au3>
; Script Start - Add your code below here


Dim $file[1]
_FileReadToArray($cmdline[1], $file)
For $i = 1 To $file[0]
	If StringInStr($file[$i], "Global $version") Then
		$file[$i] = 'Global $version = "' & $cmdline[2] & '"'
		$f = FileOpen($cmdline[1], 2)
		_FileWriteFromArray($cmdline[1], $file, 1)
		Exit
	EndIf
Next
