sub init()
    m.gameType = invalid
    m.score = 0
    m.scoreLabel = m.top.findNode("score")
    m.answerLabel = m.top.findNode("answer")
    m.tracker = m.top.findNode("tracker")
    m.baseText = "Score:  "
    m.clue = m.top.findNode("clue")
    m.clue.color = m.global.red
    m.options = m.top.findNode("options")
    m.difficulty = 1
    m.numHints = 3
    m.roster = []
    m.decoys = []
    m.size = 0
    m.correctAnswer = invalid
    m.index = 0
    m.btnFocused = invalid
    m.nextBtn = m.top.findNode("next")
    m.nextBtn.btnColor = m.global.white
    m.nextBtn.labelColor = m.global.red
    m.resultsBtn = m.top.findNode("results")
    m.resultsBtn.btnColor = m.global.white
    m.resultsBtn.labelColor = m.global.red
    m.questionNum = 0
    m.keyboard = m.top.findNode("keyboard")
    m.submitBtn = m.top.findNode("submit")
    m.keyboardGroup = m.top.findNode("keyboardGroup")
end sub

sub onOpen(params)
    if invalid <> m.global.gameType and "" <> m.global.gameType
        m.gameType = m.global.gameType
    else
        m.gameType = "Number"
    end if
    setupGame()
end sub

sub setupGame()
    m.nextBtn.visible = false
    m.resultsBtn.visible = true
    updateScore(0)
    m.questionNum = 0
    m.roster = copyArrayByVal(m.global.roster)
    m.size = m.roster.Count()
    if "Number" = m.gameType
        m.top.clueFontSize = 300
        m.numHints = 3
        m.difficulty = 1
    else if "Name" = m.gameType
        m.top.clueFontSize = 100
        m.numHints = 3
        m.difficulty = 1
    else if "Position" = m.gameType
        m.top.clueFontSize = 100
        m.numHints = 5
        m.difficulty = 1
    else if "All Alone" = m.gameType
        m.top.clueFontSize = 100
        m.numHints = 2
        m.difficulty = 2
        m.submitBtn.btnColor = m.global.red
        m.submitBtn.labelColor = m.global.navy
    end if
    startGame()
end sub

sub updateScore(delta)
    m.score += delta
    m.scoreLabel.text = m.baseText + m.score.toStr()
end sub

sub startGame()
    m.answerLabel.visible = false
    m.nextBtn.visible = false
    m.resultsBtn.visible = false
    m.keyboardGroup.visible = false
    randomNum = Rnd(m.size) - 1
    player = m.roster[randomNum]
    m.top.clueAlign = "center"
    if "Number" = m.gameType
        m.correctAnswer = player.name
    else if "Name" = m.gameType
        m.correctAnswer = player.number
    else if "Position" = m.gameType
        m.correctAnswer = player.position
    else if "All Alone" = m.gameType
        m.correctAnswer = player.number
        m.keyboard.pin = ""
        m.top.clueAlign = "top"
    end if
    m.roster.Delete(randomNum)
    m.size -= 1
    showQuestion(player)
end sub

sub showQuestion(player)
    incrementQuestionCount()
    m.decoys.clear()
    if "Number" = m.gameType
        m.clue.text = player.number
        m.decoys = copyArrayByVal(m.global.roster)
    else if "Name" = m.gameType
        m.clue.text = player.name
        m.decoys = copyArrayByVal(m.global.roster)
    else if "Position" = m.gameType
        m.clue.text = player.name
        m.decoys = copyArrayByVal(m.global.positions)
    else if "All Alone" = m.gameType
        m.clue.text = player.name
    end if

    if 1 = m.difficulty
        removeFromPotentialDecoys(player)
        m.options.removeChildrenIndex(m.options.getChildCount(),0)
        ansSpot = Rnd(m.numHints) - 1
        for i = 0 to m.numHints - 1 step 1
            fontSize = 30
            button = createObject("roSGNode","GuessButton")
            if 3 = m.numHints
                button.btnWidth = 500
                button.btnHeight = 150
                m.options.translation = [180,600]
            else if 5 = m.numHints
                button.btnWidth = 300
                button.btnHeight = 100
                m.options.translation = [180,600]
            end if
            button.id = i
            button.labelColor = m.global.white
            button.btnColor = m.global.red
            if ansSpot = i
                if "Number" = m.gameType
                    button.playerName = player.name
                else if "Name" = m.gameType
                    button.playerName = player.number
                    fontSize = 40
                else if "Position" = m.gameType
                    button.playerName = player.position
                end if
            else
                decoy = generateDecoy()
                if "Number" = m.gameType
                    button.playerName = decoy.name
                else if "Name" = m.gameType
                    button.playerName = decoy.number
                    fontSize = 40
                else if "Position" = m.gameType
                    button.playerName = decoy.position
                end if
            end if
            button.fntSize = fontSize
            m.options.appendChild(button)
        end for
    else if 2 = m.difficulty
        m.index = 0
        m.keyboardGroup.visible = true

    end if
    if 1 = m.difficulty
        m.options.setFocus(true)
    else if 2 = m.difficulty
        m.keyboard.setFocus(true)
    end if
    changeIndex(0)
end sub

sub incrementQuestionCount()
    m.questionNum += 1
    m.tracker.text = "Question: " + m.questionNum.toStr() + "/" + m.global.roster.count().toStr()
end sub

sub removeFromPotentialDecoys(player)
        for i = 0 to m.decoys.count() - 1 step 1
            if "Position" <> m.gameType
                if player.name = m.decoys[i].name and player.number = m.decoys[i].number
                    m.decoys.delete(i)
                    exit for
                end if
            else
                if player.position = m.decoys[i].position
                    m.decoys.delete(i)
                    exit for
                end if
            end if
        end for
end sub

function generateDecoy()
    num = Rnd(m.decoys.Count()) - 1
    decoy = m.decoys[num]
    removeFromPotentialDecoys(decoy)
    return decoy
end function

sub changeIndex(delta)
    if 1 = m.difficulty
        m.options.getChild(m.index).btnColor = m.global.red
        m.options.getChild(m.index).labelColor = m.global.white
    end if
    m.index += delta
    if m.index < 0 then m.index = 0
    if m.index >= m.numHints then m.index = m.numHints - 1
    if 1 = m.difficulty
        m.options.getChild(m.index).btnColor = m.global.white
        m.options.getChild(m.index).labelColor = m.global.red
    else if 2 = m.difficulty
        if 1 = m.index
            m.submitBtn.btnColor = m.global.white
            m.submitBtn.labelColor = m.global.red
        else if 0 = m.index
            m.submitBtn.btnColor = m.global.red
            m.submitBtn.labelColor = m.global.navy
        end if
    end if
end sub

sub checkAnswer()
    if 1 = m.difficulty
        name = m.options.getChild(m.index).playerName
    else if 2 = m.difficulty
        name = m.keyboard.pin
    end if
    m.answerLabel.visible = true
    if name = m.correctAnswer
        updateScore(1)
        if 1 = m.difficulty
            for i = 0 to m.numHints - 1 step 1
                child = m.options.getChild(i)
                if child.playerName = m.correctAnswer
                    child.btnColor = m.global.green
                    child.labelColor = m.global.white
                else
                    child.btnColor = m.global.red
                    child.labelColor = m.global.navy
                end if
            end for
        else if 2 = m.difficulty
            m.submitBtn.btnColor = m.global.green
            m.submitBtn.labelColor = m.global.white
        end if
        m.answerLabel.text = "Correct"
    else
        m.answerLabel.text = "The correct answer was " + m.correctAnswer
        if 2 = m.difficulty
            m.submitBtn.btnColor = m.global.red
            m.submitBtn.labelColor = m.global.white
        end if
    end if
    if 0 >= m.size
        m.nextBtn.visible = false
        m.resultsBtn.visible = true
        m.resultsBtn.setFocus(true)
    else
        m.nextBtn.visible = true
        m.nextBtn.setFocus(true)
    end if
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false
    if press
        if "left" = key
            if 1 = m.difficulty
                if not m.nextBtn.visible and not m.resultsBtn.visible then changeIndex(-1)
            else if 2 = m.difficulty
                if 1 = m.index then changeIndex(-1)
                m.keyboard.setFocus(true)
            end if
            handled = true
        else if "right" = key
            if 1 = m.difficulty
                if not m.nextBtn.visible and not m.resultsBtn.visible then changeIndex(1)
            else if 2 = m.difficulty
                if 0 = m.index then changeIndex(1)
                m.submitBtn.setFocus(true)
            end if
            handled = true
        else if "down" = key
            handled = true
        else if "OK" = key
            if (not m.nextBtn.visible and not m.resultsBtn.visible) or (m.submitBtn.visible and m.index = 1 and not m.nextBtn.visible and not m.resultsBtn.visible)
                checkAnswer()
            else if not m.resultsBtn.visible and m.nextBtn.visible
                startGame()
            else if not m.nextBtn.visible and m.resultsBtn.visible
                data = {
                    score: m.score,
                    numQuestions: m.global.roster.count()
                }
                m.global.screenManager.callFunc("goToScreen",{type: "ResultsScreen", data: data, closeCurrent: true})
            end if
            handled = true
        else if "back" = key
            m.global.screenManager.callFunc("goBack",{closeCurrent: true})
        end if
    end if
    return handled
end function