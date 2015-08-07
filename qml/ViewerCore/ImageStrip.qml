import QtQuick 2.4

Rectangle {
  id: stripHolder
  // width: 240;
  // height: 200
  // color: "red"
  opacity: 0

  Component {
    id: delegate

    Column {
      id: wrapper

      ImageTile {
        id: image

        width: 64; height: 64
        source: 'file://' + modelData
        opacity: wrapper.PathView.isCurrentItem ? 1 : .4
        Component.onCompleted: {
          strip.positionViewAtIndex(sourceIndex, PathView.Beginning)
        }
      }
    }
  }

  StripView {
    id: strip

    anchors.fill: parent
    delegate: delegate
    model: imageModel

    Keys.onSpacePressed: viewer.rotation = 0
  }

  states: [
    State {
      name: 'ENTERED'; when: mouseArea.containsMouse
      // shows the strip when hovered
      PropertyChanges {target: stripHolder; opacity: 1}
    },
    State {
      name: 'EXITED'; when: !mouseArea.containsMouse
      // hides the strip when exited
      PropertyChanges {target: stripHolder; opacity: 0}
    }
  ]

  transitions: [
    // animate the appearing and hiding of the strip
    Transition {
      to: 'EXITED'
      NumberAnimation {
        properties: "opacity"; duration: 2000;
        easing.type: Easing.OutQuad
      }
    },
    Transition {
      to: 'ENTERED'
      NumberAnimation {
        properties: "opacity"; duration: 500;
        easing.type: Easing.InQuad
      }
    }
  ]
}
