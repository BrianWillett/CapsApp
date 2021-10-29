sub main(params)

  screen = createObject("roSGscreen")
  port = createObject("roMessagePort")
  screen.setMessagePort(port)

  scene = screen.createScene("Main")
  screen.show() ' vscode_rale_tracker_entry
  scene.observeField("close",port)

  while true
      msg = wait(0,port)
      msgType = type(msg)
      if "roSGScreenEvent" = msgType
          if msgType.isScreenClose() then return
      else if "roSGNodeEvent" = msgType
        field = msg.getField()
        if field = "close" then return
      end if
  end while
end sub