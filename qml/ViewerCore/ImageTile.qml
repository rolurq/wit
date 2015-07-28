import QtQuick 2.4

Item {
  id: photoWrapper
  
  property alias source: originalImage.source

  Image {
    id: originalImage
    anchors.centerIn: parent
    fillMode: Image.PreserveAspectFit
    width: photoWrapper.width; height: photoWrapper.height

    states: State {
      when: originalImage.status == Image.Ready
      PropertyChanges {target: photoWrapper; rotation: Math.random() * (14) - 7}
    }
  }

  MouseArea {  // enables image clicking
    id: mouseArea

    cursorShape: Qt.PointingHandCursor
    anchors.fill: parent
    hoverEnabled: true
    // set the strip state when a image is hovered
    onEntered: stripHolder.state = image.state = 'ENTERED'
    onExited: {
      stripHolder.state = 'EXITED'
      image.state = ''
    }
    onClicked: {
      strip.positionViewAtIndex(
        strip.indexAt(wrapper.x, wrapper.y),
        PathView.Beginning
      )
    }
  }

  onStateChanged: if (wrapper.PathView.isCurrentItem) viewer.source = 'file://' + modelData

  states: [
    State {
      name: 'LOAD'; when: wrapper.PathView.isCurrentItem
      PropertyChanges {target: viewer; source: viewer.source = 'file://' + modelData}
    },
    State {
      name: 'ENTERED'
      PropertyChanges {target: image; opacity: 1}
      PropertyChanges {target: image; scale: 2}
    }
  ]

  transitions: [
    Transition {
      to: 'ENTERED'
      reversible: true
      NumberAnimation {
        properties: "opacity"; duration: 200;
        easing.type: Easing.InQuad
      }
      NumberAnimation {
        properties: "scale"; duration: 200;
        easing.type: Easing.InOutSine
      }
    }
  ]
}
