toStr(val) {
  if (val is "object") {
    if (type(val) == "Object") { ; val is a custom object (or an array)
      if (_objIsLinear(val)) { ; val is an array
        for _, element in val
          output .= toStr(element) . ", "
        return "[" . subStr(output, 1, -2) . "]"
      } else { ; val is a custom object that is not an array
        for key, value in val
          output .= toStr(key) . ": " . toStr(value) . ", "
        return "{" . subStr(output, 1, -2) . "}"
      }
    }
  }
  else if (type(val) == "Integer") {
    return format("{:i}", val)
  }
  else if (type(val) == "Float") {
    return format("{:f}", val)
  }
  else if (type(val) == "String") {
    return "`"" . val . "`""
  }

  return val ; in any unhandled case, just return the value passed in.


  
  /* Following are utility functions */

  _objIsLinear(obj) {
    for i in obj {
      if i !== A_Index
        return false
    }
    return true
  }
}