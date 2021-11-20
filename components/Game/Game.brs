sub init()
    m.shot = invalid
    m.shotAnimation = invalid
    m.ship = m.top.findNode("ship")
    m.score = m.top.findNode("scoreLabel")
    m.enamies = []

    createEnamies()
    
    ' timer
    'every shot will has its own timer later
    m.shotTimer = createObject("roSGNode","Timer")
    m.shotTimer.repeat= true
    m.shotTimer.duration= 0.1
    m.shotTimer.control="start"
    m.shotTimer.ObserveField("fire","shotHandling")
end sub

sub createEnamies()
    'emanies
    enamyColors = [
        "0x00FF3CFF",
        "0x00FFE6FF",
        "0x0091FFFF",
        "0x6FFF00FF",
        "0x9A00FFFF"
    ]

    x = 142
    For i = 1 To 5
    enamy = m.top.createChild("Poster")
    enamy.uri = "pkg:/images/enamy.png"

    enamy.width = 100
    enamy.height = 73
    enamy.blendColor = enamyColors[rnd(4)]   
    enamy.translation = [x , 150]
    m.enamies.push(enamy)
    x += 384 
    End for
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean  
    handled = false 
    if press then
        if key = "left" then 
            moveLeft() 
            handled = true
        else if key = "right" then
            moveRight() 
            handled = true 
        else if key = "OK" then
            fire() 
            handled = true
        endif 
    end if
    return handled
end function

sub shotHandling()
    if m.shot <> invalid then
        x = m.shot.translation.GetEntry(0)  
        y = m.shot.translation.GetEntry(1)
        if y < -10 then 
            removeShot()
            return
        end if  

        for i = m.enamies.count() - 1 To 0 step -1 
            enamy = m.enamies[i ]
            enamyX = enamy.translation.GetEntry(0)
            enamyY = enamy.translation.GetEntry(1)
            if x + 12 > enamyX and x < enamyX + 100 and y <= enamyY+72 then 
                removeShot()
                m.top.removeChild( enamy)
                m.enamies.delete(i)
                m.score.text = m.score.text.toInt() + 10 
                'this sould be changed to a next level thing
                if m.enamies.count() = 0
                    createEnamies()
                    return
                end if
            end if
        End For 
    end if 
end sub
 

sub removeShot()
    m.top.removeChild( m.shot)
    m.shot = invalid
    m.top.removeChild( m.shotAnimation)
    m.shotAnimation = invalid
end sub

sub fire()
    if m.shot = invalid then
        m.shot = m.top.createChild("Rectangle")
        m.shot.width = 12
        m.shot.height = 12
        m.shot.color ="0xFFD300FF" 
        m.shot.id = "theShot"
        x = m.ship.translation.GetEntry(0) + 44  
        y = m.ship.translation.GetEntry(1)
        m.shot.translation = [x , y]

        m.shotAnimation = m.top.createChild("Animation") 
        m.shotAnimation.duration = 4
        m.shotAnimation.easeFunction = "linear"
        interpolator = m.shotAnimation.createChild("Vector2DFieldInterpolator")
        interpolator.key = [0.0, 1.0]
        interpolator.keyValue = [[x,y],[x,-20]]
        interpolator.fieldToInterp = "theShot.translation" 

        m.shotAnimation.control = "start"
    end if

end sub

sub moveLeft()
    currentX = m.ship.translation.GetEntry(0)  
    if currentX > 90 then 
        m.ship.translation = [currentX - 50 , 930]
    end if
end sub

sub moveRight()
    currentX = m.ship.translation.GetEntry(0)  
    if currentX < 1860 then 
        m.ship.translation = [currentX + 50 , 930]
    end if
end sub