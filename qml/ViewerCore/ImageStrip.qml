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

      ImageViewer {
        id: image

        width: 64; height: 64
        source: 'file://' + modelData
        opacity: wrapper.PathView.isCurrentItem ? 1 : .4

        MouseArea {  // enables image clicking
          id: mouseArea

          cursorShape: Qt.PointingHandCursor
          anchors.fill: parent
          hoverEnabled: true
          // set the strip state when a image is hovered
          onEntered: {stripHolder.state = 'ENTERED'}
          onExited: {stripHolder.state = 'EXITED'}
          onClicked: {
            view.positionViewAtIndex(
              view.indexAt(wrapper.x, wrapper.y),
              PathView.Beginning
            )
          }
        }

        states: State {
          when: wrapper.PathView.isCurrentItem
          PropertyChanges {target: viewer; source: 'file://' + modelData}
        }
      }
    }
  }

  PathView {
    id: view

    anchors.fill: parent
    delegate: delegate
    model: imageModel
    interactive: true
    focus: true
    
    path: Path {
      // start approximately in the component middle
      startX: 120; startY: 100
      // create an ellipse with two quads
      PathQuad { x: 120; y: 25; controlX: view.count*26; controlY: 75 }
      PathQuad { x: 120; y: 100; controlX: -view.count*20; controlY: 75 }
    }
    
    Keys.onLeftPressed: decrementCurrentIndex()
    Keys.onRightPressed: incrementCurrentIndex()
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