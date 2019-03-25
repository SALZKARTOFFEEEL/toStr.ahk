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
    if (type(val) == "Func") {
      return "'Func Object' of function <" _funcObjGetName(val) ">"
    }
    if (type(val) == "BoundFunc") {
      return "'Bound Func Object'"
    }
    if (type(val) == "File") {
      return "'File Object' of file <" _fileObjGetPath(val) ">"
    }
    if (type(val) == "Gui") {
      return "'Gui Object' of GUI <" _guiObjGetName(val) ">"
    }
    if (type(val) == "Menu") {
      return "'Menu Object' with <" _menuObjGetItemCount(val) "> items"
    }
    if (type(val) == "MenuBar") {
      return "'Menu Bar Object' with <" _menubarObjGetMenuCount(val) "> menus"
    }
    if (type(val) == "ComObj") {
      return "'Com Object'"
    }


    ; following parts should be kept at the end of this function,
    ; because their performance is relatively poor

    if (subStr(type(val), -11) == ".Enumerator") {
      return "'Enumerator Object' for <" subStr(type(val), 1, -11) ">"
    }
    if (subStr(type(val), 1, 3) == "Gui") {
      return "'Gui Control Object' for <" _guictrlObjGetType(val) "> control "
      . "on GUI <" _guiObjGetName(_guictrlObjGetGui(val)) ">"
    }
    ; this check is extremely slow (takes around 50 ms on my system),
    ; it will potentially get removed, but stays as the last check, for now.
    if (type(val) == comObjType(val, "class")) { ; val is a COM object created with comObjCreate()
      return "'Com Object' of name <" comObjType(val, "name") "> and class <" type(val) ">"
    }


    return "Object of type <" type(val) ">"
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

  _funcObjGetName(funcObj) {
    return funcObj.name
  }

  ; https://docs.microsoft.com/windows/desktop/api/fileapi/nf-fileapi-getfinalpathnamebyhandlew
  _fileObjGetPath(fileObj) {
    hFile := fileObj.handle
  , varSetCapacity(lpszFilePath, 260 * 2 + 1) ; 260 is the default MAX_PATH
  , cchFilePath := 260 * 2                    ; 
  , dwFlags := 0x0 ; FILE_NAME_NORMALIZED | VOLUME_NAME_DOS
  , ret := dllCall("GetFinalPathNameByHandleW", "Ptr", hFile, "Str", lpszFilePath, "UInt", cchFilePath, "UInt", dwFlags)
    
    if (ret > 260 * 2) { ; the buffer size of 260 was too small
      varSetCapacity(lpszFilePath, ret)
    , cchFilePath := ret - 1
    , dllCall("GetFinalPathNameByHandleW", "Ptr", hFile, "Str", lpszFilePath, "UInt", cchFilePath, "UInt", dwFlags)
    }

    return _cutUncPrefix(lpszFilePath)

    ; https://docs.microsoft.com/windows/desktop/fileio/naming-a-file#maximum-path-length-limitation
    _cutUncPrefix(path) {
      if (inStr(path, "\\?\UNC\") == 1) {
        return subStr(path, 9)
      } else if (inStr(path, "\\?\") == 1) {
        return subStr(path, 5)
      } else {
        return path
      }
    }
  }

  _guiObjGetName(guiObj) {
    if (guiObj.name !== "")
      return guiObj.name
    if (guiObj.title !== "")
      return guiObj.title
  }

  _guictrlObjGetType(guictrlObj) {
    return guictrlObj.type
  }

  _guictrlObjGetGui(guictrlObj) {
    return guictrlObj.gui
  }

  ; https://docs.microsoft.com/windows/desktop/api/Winuser/nf-winuser-getmenuitemcount
  _menuObjGetItemCount(menuObj) {
    return dllCall("GetMenuItemCount", "Ptr", menuObj.handle)
  }

  ; _menuObjGetItemCount() is identical to this,
  ; this function is really just for explicity
  _menubarObjGetMenuCount(menubarObj) {
    return dllCall("GetMenuItemCount", "Ptr", menubarObj.handle)
  }
}