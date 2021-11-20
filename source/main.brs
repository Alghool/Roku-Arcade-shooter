sub Main() 

    screen = createObject("roSGScreen")
    m.port = createObject("roMessagePort")
    screen.setMessagePort(m.port)

    device = createObject("roDeviceInfo") 
    m.global = screen.getGlobalNode()
    m.global.addFields({
        deviceHeight: device.GetDisplaySize().h,
        deviceWidth: device.GetDisplaySize().w 
    }) 

    scene = screen.createScene("mainScreen")
    screen.show()

    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent" then
            if msg.isScreenClosed() then return
        end if
    end while
end sub