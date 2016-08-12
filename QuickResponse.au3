#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=quickresponse.ico
#AutoIt3Wrapper_Outfile=QuickResponse.exe
#AutoIt3Wrapper_Res_Fileversion=0.3.3.1
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Run_Before=versupdate.exe %in% %fileversion%
#AutoIt3Wrapper_Tidy_Stop_OnError=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;Additional general libraries
#include <Array.au3>
#include <GuiTreeView.au3>
#include <GuiComboBox.au3>
#include <String.au3>
#include <MsgBoxConstants.au3>
#include <GuiMenu.au3>
#include <TrayConstants.au3>
#include <GuiEdit.au3>
#include "recsearch.au3"

;Main GUI window creation
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <TreeViewConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=C:\Jack\Apps\QuickResponse\guiMain.kxf
$guiMain = GUICreate("QuickResponse", 610, 495, -1, -1, BitOR($GUI_SS_DEFAULT_GUI, $WS_SIZEBOX, $WS_THICKFRAME))
$guiMain_Tree = GUICtrlCreateTreeView(5, 5, 506, 331, BitOR($TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_SHOWSELALWAYS, $WS_BORDER))
GUICtrlSetResizing(-1, $GUI_DOCKAUTO + $GUI_DOCKLEFT + $GUI_DOCKTOP)
$guiMain_buttonNewGroup = GUICtrlCreateButton("New Group", 515, 5, 90, 25)
GUICtrlSetResizing(-1, $GUI_DOCKRIGHT + $GUI_DOCKTOP + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
GUICtrlSetTip(-1, "Creates a new Group.")
$guiMain_buttonNewSub = GUICtrlCreateButton("New Entry", 515, 35, 90, 25)
GUICtrlSetResizing(-1, $GUI_DOCKRIGHT + $GUI_DOCKTOP + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
GUICtrlSetTip(-1, "Creates a new Entry within the selected Group.")
$guiMain_buttonDelete = GUICtrlCreateButton("Delete", 515, 65, 90, 25)
GUICtrlSetResizing(-1, $GUI_DOCKRIGHT + $GUI_DOCKTOP + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
GUICtrlSetTip(-1, "Deletes the selected Group or Entry.")
$guiMain_buttonHotkey = GUICtrlCreateButton("Set Hotkeys", 515, 220, 90, 25)
GUICtrlSetResizing(-1, $GUI_DOCKRIGHT + $GUI_DOCKTOP + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
GUICtrlSetTip(-1, "Sets the hotkey to bring up the quick selector.")
$guiMain_buttonMinimize = GUICtrlCreateButton("Minimize to Tray", 515, 250, 90, 25)
GUICtrlSetResizing(-1, $GUI_DOCKRIGHT + $GUI_DOCKTOP + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
GUICtrlSetTip(-1, "Minimizes application to tray.")
$guiMain_buttonCopy = GUICtrlCreateButton("&Copy", 515, 280, 90, 55)
GUICtrlSetResizing(-1, $GUI_DOCKRIGHT + $GUI_DOCKTOP + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlSetTip(-1, "Copies the currently selected entry to the clipboard.")
$guiMain_Edit = GUICtrlCreateEdit("", 5, 340, 600, 121, BitOR($ES_WANTRETURN, $WS_HSCROLL, $WS_VSCROLL))
GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKBOTTOM)
$guiMain_buttonInsert = GUICtrlCreateButton("Insert Special", 420, 465, 90, 25)
GUICtrlSetResizing(-1, $GUI_DOCKRIGHT + $GUI_DOCKBOTTOM + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
GUICtrlSetTip(-1, "Inserts special tags like %[keywords] or $[references]")
$guiMain_buttonSave = GUICtrlCreateButton("Save", 515, 465, 90, 25)
GUICtrlSetResizing(-1, $GUI_DOCKRIGHT + $GUI_DOCKBOTTOM + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlSetTip(-1, "Saves a modified or new entry.")
$guiMain_buttonSelectAll = GUICtrlCreateButton("selectall", 1, 1, 1, 1)
GUICtrlSetState(-1, $GUI_HIDE)
;~ GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
GUISetIcon("quickresponse.ico")
_GUICtrlEdit_SetMargins($guiMain_Edit, $EC_RIGHTMARGIN, 10, 10)

$guiMain_buttonPoop = Null
If @UserName = "nkothenb" Then
	$r = Random(1, 50, 1)
	$guiMain_buttonPoop = GUICtrlCreateButton(" ", Random(0, 600, 1), Random(0, 400, 1), $r, $r, BitOR($BS_PUSHBOX, $BS_FLAT))
	GUICtrlSetState(-1, $GUI_ONTOP)
EndIf

;Hotkey GUI creation
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=C:\Jack\Apps\QuickResponse\guiKey.kxf
$guiKey = GUICreate("Hotkey", 177, 179, 284, 212, -1, -1, $guiMain)
$guiKey_radioGlobal = GUICtrlCreateRadio("Global Hotkey", 5, 5, 113, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$guiKey_radioGroup = GUICtrlCreateRadio("Group-specific Hotkey", 5, 25, 128, 17)
$guiKey_comboGroup = GUICtrlCreateCombo("", 20, 45, 145, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
GUICtrlSetState(-1, $GUI_DISABLE)
$guiKey_checkboxCtrl = GUICtrlCreateCheckbox("Ctrl", 18, 75, 40, 17)
$guiKey_checkboxAlt = GUICtrlCreateCheckbox("Alt", 68, 75, 40, 17)
$guiKey_checkboxShift = GUICtrlCreateCheckbox("Shift", 118, 75, 40, 17)
$guiKey_comboKey = GUICtrlCreateCombo("", 31, 95, 105, 25, BitOR($GUI_SS_DEFAULT_COMBO, $CBS_SIMPLE))
GUICtrlSetData(-1, " |a|b|c|d|e|f|g|h|i|j|k|l|m|n|o|p|q|r|s|t|u|v|w|x|y|z|`|1|2|3|4|5|6|7|8|9|0|-|=|[|]|\|;|" & Chr(39) & "|,|.|/|TAB|ENTER|SPACE|BACKSPACE|F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|INSERT|DELETE|HOME|END|PGUP|PGDN|NUMPAD0|NUMPAD1|NUMPAD2|NUMPAD3|NUMPAD4|NUMPAD5|NUMPAD6|NUMPAD7|NUMPAD8|NUMPAD9|NUMPADDOT|NUMPADENTER|NUMPADADD|NUMPADSUB|NUMPADMULT|NUMPADDIV|LEFT|RIGHT|UP|DOWN")
$guiKey_buttonClear = GUICtrlCreateButton("Clear Hotkey", 5, 120, 75, 25)
$guiKey_buttonSet = GUICtrlCreateButton("Set Hotkey", 96, 120, 75, 25)
$guiKey_buttonCancel = GUICtrlCreateButton("Close", 51, 150, 75, 25)
;~ GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
GUISetIcon("quickresponse.ico")

Opt("MustDeclareVars", 1) ;internal only
Opt("TrayAutoPause", 0) ;stop script from pausing when you click the tray icon
If @Compiled Then Opt("GuiCloseOnESC", 0) ;prevents ESC key from closing GUI
Opt("TrayMenumode", 1) ;removes autoit default tray icon

;Some constants for message box dialogs, these set buttons and icons
Const $mbquestion = $MB_ICONQUESTION + $MB_TOPMOST + $MB_YESNO
Const $mbquestionwarning = $MB_ICONWARNING + $MB_YESNO + $MB_DEFBUTTON2 + $MB_TOPMOST
Const $mberror = $MB_ICONERROR + $MB_TOPMOST
Const $mbnotify = $MB_ICONINFORMATION + $MB_TOPMOST

;Initializing some global variables
Global $version = "0.3.3.0"
Global $title = "QuickResponse v" & $version
Global $sel, $oldsel, $curtitle, $oldtitle, $oldedit, $editchanged, $changeButton, $qs, $qstimer, $doCopy
Global $time = TimerInit()
Global $grouplist[0]
Global $entrylist[0]

Const $hotkeyList = StringSplit("1,2,3,4,5,6,7,8,9,0,q,w,e,r,t,y,u,i,o,p,a,s,d,f,g,h,j,k,l,z,x,c,v,b,n,m", ",")

;Setting titles/tooltips for GUI and tray icon
WinSetTitle("QuickResponse", "", $title)
TraySetIcon("quickresponse.ico")
TraySetToolTip($title)

;This sets the "Quitting" function to run when the script exits
;this function removes hotkeys that no longer correspond to a group
OnAutoItExitRegister("Quitting")

Local $aAccelKeys[1][2] = [["^a", $guiMain_buttonSelectAll]]
GUISetAccelerators($aAccelKeys, $guiMain)

If StringInStr(@ScriptFullPath, "K:") Or StringInStr(@ScriptFullPath, "\\atsegvfile01\") Then
	MsgBox($mberror, "QuickResponse", "Error: Do not run this from the network share location. Make a local copy on your PC first.")
	Exit
EndIf

BuildTree()
HotkeyEnable()

GUISetState(@SW_SHOW, $guiMain)

#Region Main Loop
While 1
	Local $msg
	$msg = GUIGetMsg(1)
	Switch $msg[0]
		Case $GUI_EVENT_CLOSE, $guiKey_buttonCancel
			If $msg[1] = $guiMain Then ;close button pressed on main GUI
				If @Compiled Then ;shows warning before exiting, only if script is running as a full compiled build
					If MsgBox($mbquestion, "Exit", "Are you sure you want to quit?") = 7 Then
						ContinueLoop
					EndIf
				EndIf
				Exit
			ElseIf $msg[1] = $guiKey Then ;close button pressed on hotkey GUI
				ResetGuiKey()
				GUISetState(@SW_HIDE, $guiKey)
			EndIf

;~ 		guiMain buttons and events
		Case $guiMain_buttonNewGroup
			NewGroup()
		Case $guiMain_buttonNewSub
			NewItem()
		Case $guiMain_buttonDelete
			DeleteItem()
		Case $guiMain_buttonCopy
			CopyEntry()
		Case $guiMain_buttonInsert
			InsertSpecial()
		Case $guiMain_buttonSave
			Save()
		Case $guiMain_buttonMinimize
			GUISetState(@SW_HIDE, $guiMain)
		Case $guiMain_buttonHotkey
			ResetGuiKey()
			PreselectHotkey()
			GUISetState(@SW_SHOW, $guiKey)
		Case $guiMain_buttonPoop
			;why do i do these things
			MsgBox(0, "", "poop")
		Case $guiMain_buttonSelectAll
			_GUICtrlEdit_SetSel($guiMain_Edit, 0, -1)

;~ 		guiKey buttons and events
		Case $guiKey_buttonSet
			SetHotkey()
			HotkeyEnable()
		Case $guiKey_radioGlobal
			GUICtrlSetState($guiKey_comboGroup, $GUI_DISABLE)
			PreselectHotkey()
		Case $guiKey_radioGroup
			GUICtrlSetState($guiKey_comboGroup, $GUI_ENABLE)
			PreselectHotkey()
		Case $guiKey_comboGroup
			PreselectHotkey()
			If GUICtrlRead($guiKey_comboKey) = " " Then
				GUICtrlSetState($guiKey_buttonSet, $GUI_DISABLE)
			Else
				GUICtrlSetState($guiKey_buttonSet, $GUI_ENABLE)
			EndIf
		Case $guiKey_comboKey
			If GUICtrlRead($guiKey_comboKey) = " " Then
				GUICtrlSetState($guiKey_buttonSet, $GUI_DISABLE)
			Else
				GUICtrlSetState($guiKey_buttonSet, $GUI_ENABLE)
			EndIf
		Case $guiKey_buttonClear
			ClearHotkey()
	EndSwitch

	;activate on tray click
	$msg = TrayGetMsg()
	Switch $msg
		Case $TRAY_EVENT_PRIMARYDOWN
			GUISetState(@SW_SHOW, $guiMain)
			WinActivate($title)
	EndSwitch

	;loads relevant text when treeview selection changes
	$sel = _GUICtrlTreeView_GetSelection($guiMain_Tree)
	If $sel <> $oldsel Then
		ChangeSelection()
	EndIf

	;changes Copy button back to default text after copying
	If $changeButton = 1 And TimerDiff($time) > 2000 Then
		GUICtrlSetData($guiMain_buttonCopy, "Copy")
		$changeButton = 0
	EndIf

	;prevents user from switching away before saving changes
	If GUICtrlRead($guiMain_Edit) <> $oldedit Then
		$oldedit = GUICtrlRead($guiMain_Edit)
		GUICtrlSetState($guiMain_buttonSave, $GUI_ENABLE)
		$editchanged = 1
	EndIf

	;quickselect timeout
	If $qs = 1 And TimerDiff($qstimer) > 10000 Then
		$qs = 0
		RemoveQuickKeys()
		ShowTip("")
		$qstimer = TimerInit()
	EndIf

	;performs the copy function for the quickselect hotkeys
	;this needs to be within the main loop because calling Copy() during a function will not update the selection in the TreeView first.
	If $doCopy = 1 Then
		CopyEntry()
		$doCopy = 0
	EndIf
WEnd
#EndRegion Main Loop
#Region QuickSelect
;This gets hairy. Bear with me.
Func QuickSelectHotkey()
	Local $ini = IniReadSection("settings.ini", "Settings") ; load list of hotkeys
	For $i = 1 To $ini[0][0]
		If $ini[$i][1] = @HotKeyPressed Then ;iterate through until we find the one that triggered this function
			If $ini[$i][0] = "hkGlobal" Then ;if it's the global hotkey, call the main QuickSelect function to show full menu
				QuickSelect()
				Return
			Else
				QuickSelectShowEntries(StringTrimLeft($ini[$i][0], 2)) ;otherwise skip straight to the menu for a specific group
				ExitLoop
			EndIf
		EndIf
	Next
EndFunc   ;==>QuickSelectHotkey
Func QuickSelect()
	If $qs = 1 Then ;if the menu is already active, turn it off
		ShowTip("")
		RemoveQuickKeys()
		$qs = 0
	Else
		Local $list = _FileSearch("data\*.txt", 1)
		Dim $grouplist[0]
		Local $s = ""
		Local $a
		For $i = 1 To $list[0] ;create
			$list[$i] = StringReplace($list[$i], "data\", "")
			$list[$i] = StringReplace($list[$i], ".txt", "")
			$a = StringSplit($list[$i], "\")
			_ArrayAdd($grouplist, $a[1])
		Next
		$grouplist = _ArrayUnique($grouplist)
		For $i = 1 To $grouplist[0]
			$s = $s & $i & ": " & $grouplist[$i] & @CRLF
			HotKeySet("{NUMPAD" & $i & "}", "QuickSelectGroup")
			HotKeySet($i, "QuickSelectGroup")
		Next
		ShowTip($s,"Quick Select")
		$qstimer = TimerInit()
		$qs = 1
	EndIf
EndFunc   ;==>QuickSelect
Func QuickSelectGroup()
	RemoveQuickKeys()
	$qs = 0
	Local $key = @HotKeyPressed
	$key = StringReplace($key, "{NUMPAD", "")
	$key = StringReplace($key, "}", "")
	For $i = 1 To $grouplist[0]
		If $key = $i Then
			QuickSelectShowEntries($grouplist[$i])
			ExitLoop
		EndIf
	Next
EndFunc   ;==>QuickSelectGroup
Func QuickSelectShowEntries($groupname)
	If $qs = 1 Then ;if the menu is already active, turn it off
		ShowTip("")
		RemoveQuickKeys()
		$qs = 0
	Else
		RemoveQuickKeys()
		Local $list = _FileSearch("data\" & $groupname & "\*.txt", 1)
		Dim $entrylist[0]
		Local $a
		Local $s = ""
		For $i = 1 To $list[0]
			$list[$i] = StringReplace($list[$i], "data\", "")
			$list[$i] = StringReplace($list[$i], ".txt", "")
			_ArrayAdd($entrylist, $list[$i])
		Next
		If UBound($entrylist) < 1 Then
			MsgBox($mberror, "Error", "Error: You pressed a hotkey for a Group that does not have any Entries." & @CRLF & "Group: " & $groupname)
			Return
		EndIf
		$entrylist = _ArrayUnique($entrylist)
		For $i = 1 To $entrylist[0]
			$s = $s & $i & ": " & $entrylist[$i] & @CRLF
			HotKeySet($i, "QuickSelectEntry")
			HotKeySet("{NUMPAD" & $i & "}", "QuickSelectEntry")
		Next
		ShowTip($s,$groupname)
		$qs = 1
		$qstimer = TimerInit()
	EndIf
EndFunc   ;==>QuickSelectShowEntries
Func QuickSelectEntry()
	RemoveQuickKeys()
	Local $key = @HotKeyPressed
	Local $findgroup, $findentry, $a
	$key = StringReplace($key, "{NUMPAD", "")
	$key = StringReplace($key, "}", "")
	For $i = 1 To $entrylist[0]
		If $key = $i Then
			$a = StringSplit($entrylist[$i], "\")
			$findgroup = _GUICtrlTreeView_FindItem($guiMain_Tree, $a[1], False)
			$findentry = _GUICtrlTreeView_FindItem($guiMain_Tree, $a[2], False, $findgroup)
			_GUICtrlTreeView_SelectItem($guiMain_Tree, $findentry, $TVGN_CARET)
			ShowTip("")
			RemoveQuickKeys()
			$doCopy = 1
			$qs = 0
		EndIf
	Next
EndFunc   ;==>QuickSelectEntry
Func RemoveQuickKeys()
	For $i = 1 To 9
		HotKeySet("{NUMPAD" & $i & "}")
		HotKeySet($i)
	Next
EndFunc   ;==>RemoveQuickKeys
#EndRegion QuickSelect

#Region guiMain
Func InsertSpecial()
	Local Enum $i_Keyword = 3335, $i_Reference
	Local $hMenu_MSGS
	Local $hMenu = _GUICtrlMenu_CreatePopup()
	_GUICtrlMenu_AddMenuItem($hMenu, 'Keyword', $i_Keyword)
	_GUICtrlMenu_AddMenuItem($hMenu, 'Reference', $i_Reference)
	$hMenu_MSGS = _GUICtrlMenu_TrackPopupMenu($hMenu, $guiMain, -1, -1, 1, 1, 2)
	_GUICtrlMenu_DestroyMenu($hMenu)
	Switch $hMenu_MSGS
		Case $i_Keyword
			InsertKeyword()
		Case $i_Reference
			InsertReference()
	EndSwitch
EndFunc   ;==>InsertSpecial
Func InsertKeyword()
	Local $in, $f
	$in = InputBox("Keyword", "Type the keyword you would like to use as a reference." & @CRLF & @CRLF & "Example: ticketnumber")
	If $in = "" Then Return
	$f = "%[" & $in & "]"
	ClipPut($f)
	MsgBox($mbnotify, "Keyword", "Keyword format copied to clipboard." & @CRLF & @CRLF & $f)
EndFunc   ;==>InsertKeyword
Func InsertReference()
	Local $in, $in2, $f
	$in = InputBox("Reference", "Type the name of the Group with the Entry you would like to reference.")
	If $in = "" Then Return
	$in2 = InputBox("Reference", "Type the name of the Entry you are referencing.")
	If $in2 = "" Then Return
	$f = "$[" & $in & "\" & $in2 & "]"
	ClipPut($f)
	MsgBox($mbnotify, "Reference", "Reference format copied to clipboard." & @CRLF & @CRLF & $f)
EndFunc   ;==>InsertReference
Func DeleteItem()
	Local $text
	$text = _GUICtrlTreeView_GetText($guiMain_Tree, $sel)
	If $text = "Groups" Then
		MsgBox($mberror, "Error", "Please select a Group or Item first.")
		Return
	EndIf
	If IsGroup($sel) Then
		If MsgBox($mbquestionwarning, "Delete", "WARNING: You are deleting the group " & $text & ". This will delete all subitems." & @CRLF & @CRLF & "Continue?") = 6 Then
			DirRemove("data\" & $text, 1)
		EndIf
	Else
		If MsgBox($mbquestion, "Delete", "Are you sure you want to delete " & $text & "?") = 6 Then
			FileDelete(GetPath($sel))
		EndIf
	EndIf
	BuildTree()
EndFunc   ;==>DeleteItem
Func NewItem()
	Local $in, $file
	If _GUICtrlTreeView_GetText($guiMain_Tree, $sel) = "Groups" Then
		MsgBox($mberror, "Error", "Please select a Group first.")
		Return
	EndIf
	If Not IsGroup($sel) Then
		_GUICtrlTreeView_SelectItem($guiMain_Tree, _GUICtrlTreeView_GetParentHandle($guiMain_Tree, $sel))
		$sel = _GUICtrlTreeView_GetSelection($guiMain_Tree)
	EndIf
	$in = InputBox("New Item", "Please enter the title of the new Item." & @CRLF & "Group: " & _GUICtrlTreeView_GetText($guiMain_Tree, $sel))
	If @error Then Return
	$file = "data\" & _GUICtrlTreeView_GetText($guiMain_Tree, $sel) & "\" & $in & ".txt"
	If FileExists($file) Then
		MsgBox($mberror, "Error", "Error: Entry already exists in this group.")
		NewItem()
		Return
	EndIf
	FileWrite($file, "")
	BuildTree()
EndFunc   ;==>NewItem
Func NewGroup()
	Local $in
	$in = InputBox("New Group", "Please enter the title of the new Group")
	If @error Then Return
	If DirGetSize("data\" & $in) > 0 Then
		MsgBox($mberror, "Error", "Error: Group already exists.")
		NewGroup()
		Return
	EndIf
	If DirCreate("data\" & $in) = 0 Then
		MsgBox($mberror, "Error", "There was an error creating the directory.")
		Return
	EndIf
	BuildTree()
EndFunc   ;==>NewGroup
Func ChangeSelection()
	If $editchanged = 1 Then
		If MsgBox($mbquestion, "Changes", "Any changes you made will be lost. Do you want to continue?") = 7 Then
			_GUICtrlTreeView_SelectItem($guiMain_Tree, $oldsel)
			Return
		EndIf
	EndIf
	LoadText($sel)
	$oldsel = $sel
	$oldedit = GUICtrlRead($guiMain_Edit)
	GUICtrlSetState($guiMain_buttonSave, $GUI_DISABLE)
	$editchanged = 0
EndFunc   ;==>ChangeSelection
Func CopyEntry()
	Local $text
	$text = GUICtrlRead($guiMain_Edit)
	$text = ProcessEntry($text)
	If $text = "" Then Return
	ClipPut($text)
	GUICtrlSetData($guiMain_buttonCopy, "Copied.")
	$time = TimerInit()
	$changeButton = 1
EndFunc   ;==>CopyEntry
Func ProcessEntry($input)
	Local $text, $a, $in, $b, $f
	$text = $input
	$a = _StringBetween($text, "%[", "]")
	$a = _ArrayUnique($a)
	If Not @error Then
		For $i = 1 To $a[0]
			$in = InputBox("Custom Text", "Please provide text for: " & $a[$i])
			If $in = "" Then Return ""
			$text = StringReplace($text, "%[" & $a[$i] & "]", $in)
		Next
	EndIf
	$a = _StringBetween($text, "$[", "]")
	If Not @error Then
		$a = _ArrayUnique($a)
		For $i = 1 To $a[0]
			$b = StringSplit($a[$i], "\")
			$f = FileRead("data\" & $b[1] & "\" & $b[2] & ".txt")
			$f = ProcessEntry($f)
			$text = StringReplace($text, "$[" & $a[$i] & "]", $f)
		Next
	EndIf
	Return $text
EndFunc   ;==>ProcessEntry
Func LoadText($handle)
	Local $par, $f
	$par = _GUICtrlTreeView_GetText($guiMain_Tree, _GUICtrlTreeView_GetParentHandle($guiMain_Tree, $handle))
	If $par = "Groups" Then
		GUICtrlSetData($guiMain_Edit, "")
		GUICtrlSetState($guiMain_buttonSave, $GUI_DISABLE)
		GUICtrlSetState($guiMain_buttonCopy, $GUI_DISABLE)
		Return
	EndIf
	GUICtrlSetState($guiMain_buttonCopy, $GUI_ENABLE)
	$f = FileRead(GetPath($handle))
	GUICtrlSetData($guiMain_Edit, $f)
EndFunc   ;==>LoadText
Func Save()
	Local $f
	If MsgBox($mbquestion, "Save", "Are you sure you want to save changes to " & _GUICtrlTreeView_GetText($guiMain_Tree, $sel) & "?") = 6 Then
		$f = FileOpen(GetPath($sel), 2)
		FileWrite($f, GUICtrlRead($guiMain_Edit))
		FileClose($f)
		$editchanged = 0
		$oldedit = GUICtrlRead($guiMain_Edit)
	EndIf
EndFunc   ;==>Save
Func BuildTree()
	Local $guiMain_TreeMain, $dirSearch, $next, $t, $fileList, $a
	_GUICtrlTreeView_DeleteAll($guiMain_Tree)
	$guiMain_TreeMain = GUICtrlCreateTreeViewItem("Groups", $guiMain_Tree)
	$dirSearch = GetGroups()
	For $i = 1 To $dirSearch[0]
		$t = GUICtrlCreateTreeViewItem($dirSearch[$i], $guiMain_TreeMain)
		$fileList = _FileSearch("data\" & $dirSearch[$i] & "\*.txt", 1)
		For $j = 1 To $fileList[0]
			$a = StringReplace($fileList[$j], "data\" & $dirSearch[$i] & "\", "")
			$a = StringReplace($a, ".txt", "")
			_GUICtrlTreeView_SetBold($guiMain_Tree, GUICtrlCreateTreeViewItem($a, $t))
		Next
	Next
	_GUICtrlTreeView_Expand($guiMain_Tree, $guiMain_TreeMain)
EndFunc   ;==>BuildTree
#EndRegion guiMain

#Region guiKey
Func SetHotkey()
	Local $s = ""
	Local $key = GUICtrlRead($guiKey_comboKey)
	If $key = " " Then
		MsgBox($mberror, "Set Hotkey", "Error: Please select a key from the dropdown.")
		Return
	EndIf
	If GUICtrlRead($guiKey_checkboxCtrl) = $GUI_CHECKED Then $s = $s & "^"
	If GUICtrlRead($guiKey_checkboxAlt) = $GUI_CHECKED Then $s = $s & "!"
	If GUICtrlRead($guiKey_checkboxShift) = $GUI_CHECKED Then $s = $s & "+"
	If StringLen($key) > 1 Then
		$s = $s & "{" & $key & "}"
	Else
		$s = $s & $key
	EndIf
	If StringLen($s) = 1 Then
		If MsgBox($mbquestion, "Set Hotkey", "Note: Setting the hotkey to a single character can cause interaction issues when using other programs. It is recommended to use one of the modifiers as well." & @CRLF & "Continue?") = 7 Then
			Return
		EndIf
	EndIf
	Local $group
	If GUICtrlRead($guiKey_radioGlobal) = $GUI_CHECKED Then
		$group = "Global"
	Else
		$group = GUICtrlRead($guiKey_comboGroup)
	EndIf
	WriteSetting("hk" & $group, $s)
	$s = StringReplace($s, "+", "Shift+")
	$s = StringReplace($s, "!", "Alt+")
	$s = StringReplace($s, "^", "Ctrl+")
	MsgBox($mbnotify, "Set", $group & " hotkey set to: " & $s)
	ResetGuiKey()
	PreselectHotkey()
EndFunc   ;==>SetHotkey
Func ClearHotkey()
	Local $group
	If GUICtrlRead($guiKey_radioGlobal) = $GUI_CHECKED Then
		$group = "Global"
	Else
		$group = GUICtrlRead($guiKey_comboGroup)
	EndIf
	If MsgBox($mbquestionwarning, "Clear Hotkey", "Are you sure you want to clear the " & $group & " hotkey?") = 6 Then
		IniDelete("settings.ini", "Settings", "hk" & $group)
		MsgBox($mbnotify, "Clear Hotkey", "Hotkey cleared.")
		ResetGuiKey()
		PreselectHotkey()
	EndIf
EndFunc   ;==>ClearHotkey
Func ResetGuiKey()
	GUICtrlSetState($guiKey_checkboxAlt, $GUI_UNCHECKED)
	GUICtrlSetState($guiKey_checkboxShift, $GUI_UNCHECKED)
	GUICtrlSetState($guiKey_checkboxCtrl, $GUI_UNCHECKED)
	_GUICtrlComboBox_SetCurSel($guiKey_comboKey, 0)
	_GUICtrlComboBox_ResetContent($guiKey_comboGroup)
	Local $g = GetGroups()
	GUICtrlSetData($guiKey_comboGroup, GetGroups(1, "|"), $g[1])
	GUICtrlSetState($guiKey_buttonSet, $GUI_ENABLE)
EndFunc   ;==>ResetGuiKey
Func PreselectHotkey()
	Local $radio, $hk, $trim
	If GUICtrlRead($guiKey_radioGlobal) = $GUI_CHECKED Then
		$radio = "Global"
	Else
		$radio = GUICtrlRead($guiKey_comboGroup)
	EndIf
	GUICtrlSetState($guiKey_checkboxAlt, $GUI_UNCHECKED)
	GUICtrlSetState($guiKey_checkboxCtrl, $GUI_UNCHECKED)
	GUICtrlSetState($guiKey_checkboxShift, $GUI_UNCHECKED)
	$hk = ReadSetting("hk" & $radio)
	$trim = 0
	If $hk <> "" Then
		If StringInStr($hk, "!") Then
			GUICtrlSetState($guiKey_checkboxAlt, $GUI_CHECKED)
			$trim += 1
		EndIf
		If StringInStr($hk, "^") Then
			GUICtrlSetState($guiKey_checkboxCtrl, $GUI_CHECKED)
			$trim += 1
		EndIf
		If StringInStr($hk, "+") Then
			GUICtrlSetState($guiKey_checkboxShift, $GUI_CHECKED)
			$trim += 1
		EndIf
		$hk = StringTrimLeft($hk, $trim)
		$hk = StringReplace($hk, "{", "")
		$hk = StringReplace($hk, "}", "")
		_GUICtrlComboBox_SelectString($guiKey_comboKey, $hk)
	Else
		_GUICtrlComboBox_SetCurSel($guiKey_comboKey, 0)
	EndIf
EndFunc   ;==>PreselectHotkey
#EndRegion guiKey

#Region Internal
Func GetGroups($string = 0, $sepchar = "|")
	Local $dirSearch, $next, $list
	$dirSearch = FileFindFirstFile("data\*")
	$list = ""
	While 1
		$next = FileFindNextFile($dirSearch)
		If @error Then ExitLoop
		$list = $list & $next & $sepchar
	WEnd
	If StringRight($list, 1) = $sepchar Then $list = StringTrimRight($list, 1)
	If $string Then
		Return $list
	Else
		Return StringSplit($list, $sepchar)
	EndIf
EndFunc   ;==>GetGroups
Func GetPath($handle)
	Local $par, $item
	$par = _GUICtrlTreeView_GetText($guiMain_Tree, _GUICtrlTreeView_GetParentHandle($guiMain_Tree, $handle))
	$item = _GUICtrlTreeView_GetText($guiMain_Tree, $handle)
	If $par = "Groups" Then
		Return "data\" & $item
	Else
		Return "data\" & $par & "\" & $item & ".txt"
	EndIf
EndFunc   ;==>GetPath
Func WriteSetting($key, $value)
	IniWrite("settings.ini", "Settings", $key, $value)
EndFunc   ;==>WriteSetting
Func ReadSetting($key, $default = "")
	Return IniRead("settings.ini", "Settings", $key, $default)
EndFunc   ;==>ReadSetting
Func IsGroup($handle)
	If StringInStr(GetPath($handle), ".txt") Then
		Return 0
	Else
		Return 1
	EndIf
EndFunc   ;==>IsGroup
Func HotkeyEnable()
	Local $list = GetHotkeyList()
	For $i = 1 To $list[0]
		HotKeySet($list[$i], "QuickSelectHotkey")
	Next
EndFunc   ;==>HotkeyEnable
Func HotkeyDisable()
	Local $list = GetHotkeyList()
	For $i = 1 To $list[0]
		HotKeySet($list[$i])
	Next
EndFunc   ;==>HotkeyDisable
Func GetHotkeyList($string = 0, $sepchar = "|")
	Local $groups = GetGroups()
	Local $list = ""
	Local $r
	For $i = 1 To $groups[0]
		$r = ReadSetting("hk" & $groups[$i])
		If $r <> "" Then
			$list = $list & $r & $sepchar
		EndIf
	Next
	If StringRight($list, 1) = $sepchar Then $list = StringTrimRight($list, 1)
	$list = $list & $sepchar & ReadSetting("hkGlobal")
	If $string Then
		Return $list
	Else
		Return StringSplit($list, $sepchar)
	EndIf
EndFunc   ;==>GetHotkeyList
Func Quitting()
	Local $groups = GetGroups()
	Local $ini = IniReadSection("settings.ini", "Settings")
	If @error Then Return
	For $i = 1 To $ini[0][0]
		For $j = 1 To $groups[0]
			If StringTrimLeft($ini[$i][0], 2) = $groups[$j] Or $ini[$i][0] = "hkGlobal" Then
				ContinueLoop (2)
			EndIf
		Next
		IniDelete("settings.ini", "Settings", $ini[$i][0])
	Next
EndFunc   ;==>Quitting
Func ShowTip($text,$title="")
	If $text = "" Then
		ToolTip("")
	Else
		ToolTip($text,@DesktopWidth/2-100,0,$title,0)
	EndIf
EndFunc
#EndRegion Internal
