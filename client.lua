local dfps
local fps = 0
local prevframes = 0
local curframes = 0
local prevtime = 0
local curtime = 0

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
			if fps == 0 then
				Draw("FPS ERROR", 255, 0, 0, 0.95, 0.97, 0.35, 0.35, 1, true)
			elseif fps >= 1 and fps <= 30 then
				Draw("" .. fps .. "", 255, 0, 0, 0.99, 0.97, 0.35, 0.35, 1, true)
			elseif fps >=31 and fps <= 50 then
				Draw("" .. fps .. "", 255, 255, 0, 0.99, 0.97, 0.35, 0.35, 1, true)
			elseif fps >= 51 then
				Draw("" .. fps .. "", 0, 255, 0, 0.99, 0.97, 0.35, 0.35, 1, true)
			end
	end
end)

Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) or not NetworkIsSessionStarted() do
		Citizen.Wait(0)
		prevframes = GetFrameCount()
		prevtime = GetGameTimer()
	end
	while true do
		curtime = GetGameTimer()
		curframes = GetFrameCount()
	    if((curtime - prevtime) > 1000) then
			fps = (curframes - prevframes) - 1				
			prevtime = curtime
			prevframes = curframes
	    end
		Citizen.Wait(0)
	end
end)

function _DrawRect(x, y, width, height, r, g, b, a, layer)
	Citizen.InvokeNative(0x61BB1D9B3A95D802, layer)
	DrawRect(x, y, width, height, r, g, b, a)
end

function Draw(text, r, g, b, x, y, width, height, layer, center)
	SetTextColour(r, g, b, 127)
	SetTextFont(0)
	SetTextScale(width, height)
	SetTextWrap(0.0, 1.0)
	SetTextCentre(center)
	SetTextDropshadow(0, 0, 0, 0, 0)
	SetTextEdge(1, 0, 0, 0, 205)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	Citizen.InvokeNative(0x61BB1D9B3A95D802, layer)
	DrawText(x, y)
end
