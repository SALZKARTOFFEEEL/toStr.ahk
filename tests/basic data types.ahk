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



output("abcdefg")

output(123456789)

output(-123.4567)

output([1, 2, 3])

output({a: "1", b: 2})


; a few oddities:

output(-0) ; equals output(0) or output(+0) – AHK converts -0 to +0 before runtime

output(0x123) ; equals output(291) – AHK converts hexadecimal numbers to pure (decimal) numbers before runtime

output(true, false) ; equals output(1, 0) – true and false are really just variables containing the numbers 1 and 0 respectively

output({}, []) ; empty arrays and empty objects are indistinguishable for my implementation of _objIsLinear()