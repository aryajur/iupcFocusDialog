-- iupcFocusDialog test bench
	-- Code to replace \.. in the paths to absolute paths so that Zerobrane debugging works
	local newPath
	for path in package.path:gmatch("[^;]+") do
		local strt,stp = path:find([[\..]],1,true)
		while strt do
			if strt > 1 then
				path = path:sub(1,path:sub(1,strt-1):find([[%\[^%\]+$]])-1)..path:sub(stp+1,-1)
				strt,stp = path:find([[\..]],1,true)
			else		
				strt = nil
			end
		end
		if not newPath then
			newPath = path
		else
			newPath = newPath..";"..path
		end
	end
	package.path = newPath

	newPath = nil
	for path in package.cpath:gmatch("[^;]+") do
		local strt,stp = path:find([[\..]],1,true)
		while strt do
			if strt > 1 then
				path = path:sub(1,path:sub(1,strt-1):find([[%\[^%\]+$]])-1)..path:sub(stp+1,-1)
				strt,stp = path:find([[\..]],1,true)
			else		
				strt = nil
			end
		end
		if not newPath then
			newPath = path
		else
			newPath = newPath..";"..path
		end
	end
	package.cpath = newPath

fd = require("iupcFocusDialog")
print(fd)

lbl = iup.label{title = "Hello There"}
tb = iup.text{title = "Text Box", value = "Default Text"}
dlg = iup.dialog{iup.vbox{lbl,tb}; title="Dialog",size="QUARTERxQUARTER",shrink = "YES"}
--dlg:show()

--print("Label and parent",tostring(lbl),tostring(iup.GetParent(lbl)))
fd.popup(dlg)

if (iup.MainLoopLevel()==0) then
  iup.MainLoop()
end


