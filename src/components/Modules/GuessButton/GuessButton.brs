sub init()
    m.nameLabel = m.top.findNode("name")
    m.btn = m.top.findNode("button")
end sub

sub alignName()
    m.nameLabel.text = m.top.playerName
    m.nameLabel.vertalign = "center"
    m.nameLabel.horizAlign = "center"
end sub

sub adjustWidth()
    m.btn.width = m.top.btnWidth
    m.nameLabel.width = m.top.btnWidth
end sub

sub adjustHeight()
    m.btn.height = m.top.btnHeight
    m.nameLabel.height = m.top.btnHeight
end sub