toStr(val) {
  if (val is "object") {
    
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
}