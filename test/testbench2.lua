
fd = require("iupcFocusDialog")
print(fd)

list = iup.list{bgcolor=iup.GetGlobal("DLGBGCOLOR"),multiple="YES",["1"]="first item",["2"]="Second item"}
vb = iup.vbox{list}
dlg = iup.dialog{vb; size="QUARTERxQUARTER",border="NO",resize="NO",minbox="NO",menubox="NO"}

button = iup.button { title="Show" }
vbox = iup.vbox { iup.label {title="Label"}, button  }
dlg2 = iup.dialog{vbox; title="Dialog"}
dlg2:show()

function button:action()
	

	--print("Label and parent",tostring(lbl),tostring(iup.GetParent(lbl)))
	fd.popup(dlg,700,670)

end

print(dlg.screenposition,list.position,dlg.clientoffset)

if (iup.MainLoopLevel()==0) then
  iup.MainLoop()
end


