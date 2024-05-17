local warn = false
local function receiver()
    local per = peripheral.find("modem",function (name,peripheral) return peripheral.isWireless() end)
    if not per then return end
    local channel = settings.get("channelID",nil)
    if not channel then warn = true return end
    per.open(channel)
    while true do
        local event = {os.pullEvent("modem_message")}
        if event[5][1] == "key" or event[5][1] == "char" then
            os.queueEvent(table.unpack(event[5]))
        end
    end
end


local function startShell()
    term.clear()
    term.setCursorPos(1,1)
    term.setTextColor(colors.red)
    if warn then
        print("Remote keyboard is running but has no channel set.")
        print("Set one with \"set channelID <5 numbers>\"")
    else
        print("Remote keyboard driver is running!")
    end
    shell.run("shell")
end


parallel.waitForAll(receiver,startShell)