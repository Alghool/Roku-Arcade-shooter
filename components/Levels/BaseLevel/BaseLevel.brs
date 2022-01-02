sub init()  
end sub 

sub createEnamies(enamiesCount as integer)
    'emanies
    enamyColors = [
        "0x00FF3CFF",
        "0x00FFE6FF",
        "0x0091FFFF",
        "0x6FFF00FF",
        "0x9A00FFFF"
    ]
    spacer = m.global.deviceWidth / enamiesCount 
    ?spacer
    x = spacer / 2
    ?x
    enamies = []
    For i = 1 To enamiesCount
        enamy = createObject("roSGNode", "Poster")
        enamy.uri = "pkg:/images/enamy.png"

        enamy.width = 100
        enamy.height = 73
        enamy.blendColor = enamyColors[rnd(4)]   
        enamy.translation = [x , 150]
        m.top.appendChild(enamy)
        enamies.push(enamy)
        x += spacer 
    End for
    m.top.enamies = enamies
end sub


sub killEnamy(enamy as object, i as integer)
    m.top.removeChild(enamy)
    enamies = m.top.enamies
    enamies.delete(i)
    m.top.enamies = enamies
end sub





