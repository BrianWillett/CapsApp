sub init()
    m.percentage = invalid
    m.playAgain = m.top.findNode("playAgain")
    m.homeScreen = m.top.findNode("homeScreen")
    m.label = m.top.findNode("percentage")
    m.index = 0
    m.options = m.top.findNode("options")
end sub

sub onOpen(params)
    if invalid <> params and invalid <> params.data
        if invalid <> params.data.score and invalid <> params.data.numQuestions
            m.percentage = (params.data.score / params.data.numQuestions) * 100
        end if
    end if
    displayResults()
end sub

sub displayResults()
    if invalid <> m.percentage
        leftSide = fix(m.percentage)
        twoDec = leftSide.toStr()
        rightSide = (m.percentage - leftSide).toStr()
        splitIt = rightSide.split(".")
        rightSide = splitIt[1]
        if invalid <> rightSide
            if rightSide.len() >= 2
                rightSide = Left(rightSide,2)
            else if rightSide.len() = 1
                rightSide = rightside + "0"
            end if
            if "0" <> rightSide then twoDec =  twoDec + "." + rightSide
        end if
        m.playAgain.btnColor = m.global.red
        m.playAgain.labelColor = m.global.navy
        m.homeScreen.btnColor = m.global.red
        m.homeScreen.labelColor = m.global.navy
        m.label.text = twoDec + "%"
        m.label.color = m.global.red
    end if
    changeIndex(0)
end sub

sub changeIndex(delta)
    m.options.getChild(m.index).btnColor = m.global.red
    m.options.getChild(m.index).labelColor = m.global.navy
    m.index += delta
    if m.index < 0 then m.index = 0
    if m.index >= 2 then m.index = 1
    m.options.getChild(m.index).btnColor = m.global.white
    m.options.getChild(m.index).labelColor = m.global.navy
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false
    if press
        if "left" = key
            changeIndex(-1)
            handled = true
        else if "right" = key
            changeIndex(1)
            handled = true
        else if "OK" = key
            if 0 = m.index
                m.global.screenManager.callFunc("goToScreen",{type: "GameScreen", closeCurrent: true})
            else if 1 = m.index
                m.global.screenManager.callFunc("goToScreen",{type: "HomeScreen", closeCurrent: true})
            end if
            handled = true
        end if
    end if
    return handled
end function