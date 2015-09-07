--****h* iupcFocusDialog
-- ! Module
-- Module that provides functionality to present any dialog as a temporary item which disappears when it looses focus
-- ! Creation Date
-- 9/6/2015
--@@END@@

local iup = iup or require("iuplua")
local tostring = tostring
local type = type
local tonumber = tonumber

local print = print

-- Create the module table here
local M = {}
package.loaded[...] = M
_ENV = M		-- Lua 5.2+

_VERSION = "1.15.9.7"

-- dialog is the handle for the dialog
-- xmy are the screen coordinates relative to shich the dialog has to be displayed
function popup(dlg,x,y)
	if not x or type(x) ~= "number" then
		x = iup.CENTER
	end
	if not y or type(y) ~= "number" then
		y = iup.CENTER
	end	
	
	-- Create list of controls in the dialog
	local controls = {tostring(dlg)}
	local done
	local currControl = dlg
	while not done do
		if not iup.GetChild(currControl,0) then
			-- Check the sibling
			if not iup.GetBrother(currControl) then
				-- Go back up the hierarchy
				done = true
				while iup.GetParent(currControl) do
					currControl = iup.GetParent(currControl)
					if iup.GetBrother(currControl) then
						currControl = iup.GetBrother(currControl)
						controls[#controls + 1] = tostring(currControl)
						done = nil
						break
					end
				end
			else
				-- There is a brother 
				currControl = iup.GetBrother(currControl)
				controls[#controls + 1] = tostring(currControl)
			end
		else
			-- This has a child
			currControl = iup.GetChild(currControl,0)
			controls[#controls + 1] = tostring(currControl)
		end
	end
	
	for i = 1,#controls do
		print(controls[i])
	end
	
	-- Timer to check if any of the elements have focus
	local tim = iup.timer{time=10,run="NO"}
	function tim:action_cb()
		tim.run = "NO"
		--print("timer")
		--[[
		if dlg.visible == "NO" then
			tim:destroy()
			return
		end
		]]
		local fc = tostring(iup.GetFocus())
		--print(fc)
		-- Check if it matches any of the controls
		
		local match
		for i = 1,#controls	do
			if controls[i] == fc then
				match = true
				break
			end
		end
		if not match then
			--print("lost focus")
			dlg:hide()
			tim:destroy()
		else
			tim.run = "YES"
		end
		--tim.run = "YES"
	end	
	-- Show the dialog appropriately
	local w,h = iup.GetGlobal("FULLSIZE"):match("(.-)x(.+)")
	w,h = tonumber(w),tonumber(h)
	dlg:map()
	local dw,dh = dlg.rastersize:match("(.-)x(.+)")
	dw,dh = tonumber(dw),tonumber(dh)
	if y+dh >= h then
		y = y-dh
	end
	if x+dw >= w then
		x = x-dw
	end
	dlg:showxy(400,400)
	tim.run = "YES"
end