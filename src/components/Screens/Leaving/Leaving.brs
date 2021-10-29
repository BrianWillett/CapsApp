sub init()
    m.yesBtn = m.top.findNode("yes")
    m.noBtn = m.top.findNode("no")
    m.index = 1
end sub

sub onOpen(params)
    m.top.questColor = m.global.white
    m.top.yesBtnColor = m.global.red
    m.top.yesLabelColor = m.global.navy
    m.top.noBtnColor = m.global.red
    m.top.noLabelColor = m.global.navy
    updateIndex(0)
end sub

sub updateIndex(delta)
    m.index += delta
    if m.index < 0 then m.index = 0
    if m.index > 1 then m.index = 1
    if m.index = 0
        m.top.yesBtnColor = m.global.white
        m.top.yesLabelColor = m.global.red
        m.top.noBtnColor = m.global.red
        m.top.noLabelColor = m.global.navy
        m.yesBtn.setFocus(true)
    else m.index = 1
        m.top.yesBtnColor = m.global.red
        m.top.yesLabelColor = m.global.navy
        m.top.noBtnColor = m.global.white
        m.top.noLabelColor = m.global.red
        m.noBtn.setFocus(true)
    end if
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false
    if press
        if "left" = key
            updateIndex(-1)
            handled = true
        else if "right" = key
            updateIndex(1)
            handled = true
        else if "OK" = key
            handled = true
            if m.yesBtn.isInFocusChain() then handled = false
            if m.noBtn.isInFocusChain() then m.global.screenManager.callFunc("goBack",{closeCurrent: true})
        else if "back" = key
            m.global.screenManager.callFunc("goBack",{closeCurrent: true})
            handled = true
        end if
    end if
    return handled
end function