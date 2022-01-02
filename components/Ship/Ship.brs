sub init()
    m.top.uri="pkg:/images/ship.png"
    m.top.width="100"
    m.top.height="106"
    m.yLocation = m.global.deviceHeight - m.top.height - m.global.borderWidth
    m.leftLimit = m.global.borderWidth + 40
    m.rightLimit = m.global.deviceWidth - m.global.borderWidth - 10
    ?m.global
end sub

sub moveLeft()
    currentX = m.top.translation.GetEntry(0)  
    if currentX > m.leftLimit then 
        m.top.translation = [currentX - m.top.width/2 ,  m.yLocation]
    end if
end sub

sub moveRight()
    currentX = m.top.translation.GetEntry(0)  
    if currentX < m.rightLimit then 
        m.top.translation = [currentX + m.top.width/2 ,  m.yLocation]
    end if
end sub

function fire() as object
   
        shot = createObject("roSGNode", "Rectangle")
        shot.width = 12
        shot.height = 12
        shot.color ="0xFFD300FF" 
        shot.id = "theShot"
        x = m.top.translation.GetEntry(0) +  (m.top.width / 2 - 6) 
        y = m.top.translation.GetEntry(1)
        shot.translation = [x , y]
        return shot
end function
