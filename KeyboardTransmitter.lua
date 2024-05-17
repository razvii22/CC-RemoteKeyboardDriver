local modem = peripheral.find("modem",function (name, wrapped) return wrapped.isWireless() end)
if not modem then error("No wireless modem detected.") end
local history = settings.get("keyboardDriverHistory",{})
write("Computer address:")
local id = read(nil,history)
if not tonumber(id) then error("Please provide a valid ID.") end
if not (#id == 5) then error("Please provide a valid ID.") end
history[#history+1] = tostring(id)
settings.set("keyboardDriverHistory",history)
settings.save()
id = tonumber(id)
local x,y = term.getCursorPos()

while true do
    local event = {os.pullEvent()}
    if event[1] == "key" or event[1] == "char" then
        modem.transmit(id,id,event)
    end
    if event[1] == "key" then
        term.setCursorPos(x,y)
        term.clearLine()
        print("Sending:"..keys.getName(event[2]))
    end
end