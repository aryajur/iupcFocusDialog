-- Things to test
-- New Dialog shown with focus on different elements without it disappearing
-- Focus dialog created over another dialog and then parent dialog closed

-- iupcFocusDialog test bench


require("zerobranedebug")	-- To allow breakpoints in the other files to work 

fd = require("iupcFocusDialog")
print(fd)

lbl = iup.label{title = "Hello There"}
tb = iup.text{title = "Text Box", value = "Default Text"}
dlg = iup.dialog{iup.vbox{lbl,tb}; title="Dialog",size="QUARTERxQUARTER",shrink = "YES"}
--dlg:show()

--print("Label and parent",tostring(lbl),tostring(iup.GetParent(lbl)))
fd.popup(dlg,700,670)

print(tb.position,dlg.screenposition,lbl.position,dlg.clientoffset)

if (iup.MainLoopLevel()==0) then
  iup.MainLoop()
end


