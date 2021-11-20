sub Init() 
    m.startBtn = m.top.findNode("startBtn") 
    m.top.backgroundColor = "0x000000FF"
    m.top.backgroundURI = "" 
    m.startBtn.setFocus(true)
    m.startBtn.observeField("buttonSelected","startTheGame")

    m.dotsArr = []
    m.indexRef = 1
    ' timer
    m.timer = createObject("roSGNode","Timer")
    m.timer.repeat= true
    m.timer.duration=1
    m.timer.control="start"
    m.timer.ObserveField("fire","dotsHandling")
end sub

sub dotsHandling()
    if(m.dotsArr.count() < 10) then 
        m.newDot = m.top.createChild("Rectangle")
        m.newDot.width = 5
        m.newDot.height = 5
        m.newDot.color ="0xFFFFFFFF"
        m.newDot.id = m.indexRef.toStr() 
        x = rnd(1920)
        y = rnd(1080) 
        m.newDot.translation = [x,y]
        m.dotsArr.push(m.newDot)
        
        newDotAnimation = m.top.createChild("Animation")
        newDotAnimation.id = "animation" + m.indexRef.toStr() 
        newDotAnimation.duration = 14
        newDotAnimation.easeFunction = "linear"
        interpolator = newDotAnimation.createChild("Vector2DFieldInterpolator")
        interpolator.key = [0.0, 1.0]
        interpolator.keyValue = [[x,y],[rnd(1920),rnd(1080)]]
        interpolator.fieldToInterp = m.indexRef.toStr()+".translation" 

        newDotAnimation.control = "start"

        m.indexRef++
    else
        oldDot = m.dotsArr.shift()
        oldDotId = oldDot.id
        m.top.removeChild(oldDot)
        m.top.removeChild("animation" + oldDotId )    
    end if

end sub

sub startTheGame()
    m.startBtn.visible = false
    game = m.top.createChild("Game")
    game.setFocus(true)
end sub