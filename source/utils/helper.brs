function getResolution()
    'this function is very dump please made it smarter
    deviceResolution = {}
    device = createObject("roDeviceInfo")  
    modelDetails = device.getModelDetails()
    if modelDetails.modelNumber = "4200X" then 
        deviceResolution = {
            height: 1080,
            width: 1920
        }
    else
        deviceResolution = {
            height: device.GetDisplaySize().h,
            width: device.GetDisplaySize().w
        }
    end if
    return deviceResolution
end function