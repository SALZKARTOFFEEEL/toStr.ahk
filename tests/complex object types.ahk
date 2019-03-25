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