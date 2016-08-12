Func _FileSearch($szMask, $nOption)
	Local $szRoot = ""
	Local $hFile = 0
	Local $szBuffer = ""
	Local $szReturn = ""
	Local $szPathList = "*"
	Dim $aNULL[1]
	If Not StringInStr($szMask, "\") Then
		$szRoot = @ScriptDir & "\"
	Else
		While StringInStr($szMask, "\")
			$szRoot = $szRoot & StringLeft($szMask, StringInStr($szMask, "\"))
			$szMask = StringTrimLeft($szMask, StringInStr($szMask, "\"))
		WEnd
	EndIf
	If $nOption = 0 Then
		_FileSearchUtil($szRoot, $szMask, $szReturn)
	Else
		While 1
			$hFile = FileFindFirstFile($szRoot & "*.*")
			If $hFile >= 0 Then
				$szBuffer = FileFindNextFile($hFile)
				While Not @error
					If $szBuffer <> "." And $szBuffer <> ".." And _
							StringInStr(FileGetAttrib($szRoot & $szBuffer), "D") Then _
							$szPathList = $szPathList & $szRoot & $szBuffer & "*"
					$szBuffer = FileFindNextFile($hFile)
				WEnd
				FileClose($hFile)
			EndIf
			_FileSearchUtil($szRoot, $szMask, $szReturn)
			If $szPathList == "*" Then ExitLoop
			$szPathList = StringTrimLeft($szPathList, 1)
			$szRoot = StringLeft($szPathList, StringInStr($szPathList, "*") - 1) & "\"
			$szPathList = StringTrimLeft($szPathList, StringInStr($szPathList, "*") - 1)
		WEnd
	EndIf
	If $szReturn = "" Then
		$aNULL[0] = 0
		Return $aNULL
	Else
		Return StringSplit(StringTrimRight($szReturn, 1), "*")
	EndIf
EndFunc   ;==>_FileSearch
Func _FileSearchUtil(ByRef $ROOT, ByRef $MASK, ByRef $RETURN)
	Local $szBuffer
	Local $hFile = FileFindFirstFile($ROOT & $MASK)
	If $hFile >= 0 Then
		$szBuffer = FileFindNextFile($hFile)
		While Not @error
			If $szBuffer <> "." And $szBuffer <> ".." Then _
					$RETURN = $RETURN & $ROOT & $szBuffer & "*"
			$szBuffer = FileFindNextFile($hFile)
		WEnd
		FileClose($hFile)
	EndIf
EndFunc   ;==>_FileSearchUtil