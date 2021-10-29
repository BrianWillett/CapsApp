sub init()
  roster = getRoster()
  positions = getPositions()
  m.global.append({
    screenManager: createObject("roSGNode", "ScreenManager")
  })
  m.global.addFields({roster:roster,positions:positions,navy:"#041E42",red:"#C8102E",white:"#FFFFFF",green:"#559955",gameType:""})

  m.top.backgroundUri = ""
  m.top.backgroundColor= m.global.navy
  onOpen()
end sub

sub onOpen()
  m.global.screenManager.callFunc("goToScreen",{type:"HomeScreen"})
end sub

function onKeyEvent(key as string, press as boolean) as boolean
  handled = false
  if press
    if "OK" = key
      currScreen = m.global.screenManager.callFunc("fetchCurrentScreen")
      if "Leaving" = currScreen.id
        m.top.close = true
      else
        m.global.screenManager.callFunc("goToScreen",{type:"Leaving"})
      end if
      handled = true
    end if
  end if
  return handled
end function