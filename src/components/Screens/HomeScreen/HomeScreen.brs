sub init()
    m.list = m.top.findNode("modeSelectionList")
    m.inFocus = invalid
end sub

sub onOpen(params)
    m.list.setFocus(true)
    m.list.color = m.global.red
    m.list.observeField("itemFocused","onItemFocus")
    m.list.observeField("itemSelected","onSelection")
end sub

sub onItemFocus(event)
    m.inFocus = m.list.content.getChild(event.getData())
end sub

sub onSelection()
    if invalid <> m.inFocus and invalid <> m.inFocus.title
        m.global.gameType = m.inFocus.title
        m.global.screenManager.callFunc("goToScreen",{type: "GameScreen"})
    end if
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false
    if press
        if "back" = key
            m.global.screenManager.callFunc("goBack",{})
            handled = true
        else if "OK" = key
            handled = true
        end if
    end if
    return handled
end function