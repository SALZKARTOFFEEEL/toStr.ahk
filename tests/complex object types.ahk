#include %A_ScriptDir%\..
#include toStr.ahk

; this function writes its inputs to StdOut *while applying toStr()*:
output(vals*) {
	stdout := fileOpen("*", "w")
	for i, val in vals {
		stdout.writeLine(toStr(val))
	}
	stdout.close()
}



output(func("toStr"))

output(func("toStr").bind("abc"))

output(fileOpen(A_ScriptFullPath, "r"))

output(gui := guiCreate(, "test"))

output(gui.addText())

output(A_TrayMenu)

menubar := menubarCreate(), menubar.add("abc", () =>)
output(menubar)

output(gui._NewEnum())

output(comObjCreate("Scripting.Dictionary"))

regexMatch("this is a test string! test test test", "(this)\s*(.+)!", match)
output(match)

output(exception("blablabla")) ; prove that there is no such thing as an exception object :(


; a few oddities:

output((val) => toStr(val)) ; fat-arrow functions are anonymous, they don't have a name

output(fileOpen("*", "r")) ; StdIn, StdOut, or StdErr don't have file names – the same goes for any other file stream that doesn't involve the file system