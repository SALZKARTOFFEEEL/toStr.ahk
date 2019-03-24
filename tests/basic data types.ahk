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



output("abcdefg", "")
output(123456789, 0)
output(-123.4567, 0.0)
output([1, 2, 3], [])
output({a: "1", b: 2}, {})