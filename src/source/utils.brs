
function copyArrayByVal(arrayToCopy)
  copied = []
  for i = 0 to arrayToCopy.count() - 1 step 1
    copied.push(arrayToCopy[i])
  end for
  return copied
end function

function getPositions()
  positions = [{"position":"Right Wing"},{"position":"Left Wing"},{"position":"Center"},{"position":"Defense"},{"position":"Goalie"}]
  return positions
end function

function getRoster()
    roster = [
        {
          "name": "Nicklas Backstrom",
          "position": "Center",
          "number":"19"
        },
        {
          "name": "John Carlson",
          "position": "Defense",
          "number":"74"
        },
        {
          "name": "Nic Dowd",
          "position": "Center",
          "number":"26"
        },
        {
          "name": "Lars Eller",
          "position": "Center",
          "number":"20"
        },
        {
          "name": "Martin Fehervary",
          "position": "Defense",
          "number":"42"
        },
        {
          "name": "Carl Hagelin",
          "position": "Left Wing",
          "number":"62"
        },
        {
          "name": "Garnet Hathaway",
          "position": "Right Wing",
          "number":"21"
        },
        {
          "name": "Matt Irwin",
          "position": "Defense",
          "number":"52"
        },
        {
          "name": "Nick Jensen",
          "position": "Defense",
          "number":"3"
        },
        {
          "name": "Evgeny Kuznetsov",
          "position": "Center",
          "number":"92"
        },
        {
          "name": "Hendrix Lapierre",
          "position": "Center",
          "number":"29"
        },
        {
          "name": "Beck Malenstyn",
          "position": "Right Wing",
          "number":"47"
        },
        {
          "name": "Anthony Mantha",
          "position": "Right Wing",
          "number":"39"
        },
        {
          "name": "Connor McMichael",
          "position": "Center",
          "number":"24"
        },
        {
          "name": "Dmitry Orlov",
          "position": "Defense",
          "number":"9"
        },
        {
          "name": "TJ Oshie",
          "position": "Right Wing",
          "number":"77"
        },
        {
          "name": "Alexander Ovechkin",
          "position": "Left Wing",
          "number":"8"
        },
        {
          "name": "Ilya Samsonov",
          "position": "Goalie",
          "number":"30"
        },
        {
          "name": "Justin Schulz",
          "position": "Defense",
          "number":"2"
        },
        {
          "name": "Connor Sheary",
          "position": "Left Wing",
          "number":"73"
        },
        {
          "name": "Daniel Sprong",
          "position": "Right Wing",
          "number":"10"
        },
        {
          "name": "Trevor Van Riemsdyk",
          "position": "Defense",
          "number":"57"
        },
        {
          "name": "Vitek Vanecek",
          "position": "Goalie",
          "number":"41"
        },
        {
          "name": "Tom Wilson",
          "position": "Right Wing",
          "number":"43"
        }
      ]

      return roster
end function