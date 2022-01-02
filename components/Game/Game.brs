sub init()
    m.currentLevel = 1
    m.level = m.top.createChild("Level" + m.currentLevel.toStr())
    m.level.setFocus(true)
    m.ship = m.top.findNode("ship")
    m.shot = invalid
    m.score = m.top.findNode("scoreLabel")
    ' timer
    'every shot will has its own timer later
    m.shotTimer = createObject("roSGNode","Timer")
    m.shotTimer.repeat= true
    m.shotTimer.duration= 0.2
    m.shotTimer.ObserveField("fire","shotHandling") 
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean  
    handled = false  
    
    if press then
        if key = "left" then 
            m.ship.callFunc("moveLeft")
            handled = true
        else if key = "right" then
            m.ship.callFunc("moveRight")
            handled = true 
        else if key = "OK" then
            tryToShot()
            handled = true
        endif 
    end if
    return handled
end function

sub tryToShot()
    if m.shot = invalid then
        m.shot = m.ship.callFunc("fire") 
        m.top.appendChild(m.shot)
        x = m.shot.translation.GetEntry(0) 
        y = m.shot.translation.GetEntry(1)
    
        m.shotAnimation = m.top.createChild("Animation") 
        m.shotAnimation.duration = 4
        m.shotAnimation.easeFunction = "linear"
        interpolator = m.shotAnimation.createChild("Vector2DFieldInterpolator")
        interpolator.key = [0.0, 1.0]
        interpolator.keyValue = [[x,y],[x,-20]]
        interpolator.fieldToInterp = "theShot.translation" 

        m.shotTimer.control="start"
        m.shotAnimation.control = "start" 
    end if
end sub

sub shotHandling()
    if m.shot <> invalid then
        x = m.shot.translation.GetEntry(0)  
        y = m.shot.translation.GetEntry(1)
        if y < -10 then 
            removeShot()
            return
        end if  
        ?m.level.enamies.count()

        for i = m.level.enamies.count() - 1 To 0 step -1 
            enamy = m.level.enamies[i]
            enamyX = enamy.translation.GetEntry(0)
            enamyY = enamy.translation.GetEntry(1)
            if x + 12 > enamyX and x < enamyX + 100 and y <= enamyY+72 then 
                removeShot()
                m.level.callFunc("killEnamy", enamy, i)
                m.score.text = m.score.text.toInt() + 10 
            
                'this sould be changed to a next level thing
                if m.level.enamies.count() = 0
                    m.top.removeChild("Level" + m.currentLevel.toStr())
                    m.currentLevel += 1
                    m.level = m.top.createChild("Level" + m.currentLevel.toStr())
                    m.level.setFocus(true)
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
    m.shotTimer.control="stop"
end sub