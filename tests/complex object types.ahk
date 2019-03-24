#include %A_ScriptDir%\..
#include toStr.ahk

; this function writes its inputs to StdOut *while applying toStr()*:
output(vals*) {
	stdout := fileOpen("*", "w")
	for i, val in vals {
		stdout.writeLine(toStr(val))
	}
	stdout.Close()
}



output(func("toStr"))