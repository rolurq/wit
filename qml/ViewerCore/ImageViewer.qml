import QtQuick 2.4

Item {
  id: photoWrapper
  
  property alias source: originalImage.source

  // Rectangle {
  //   color: 'white'
  //   anchors.centerIn: parent
  //   antialiasing: true
  //   width: originalImage.paintedWidth + 3
  //   height: originalImage.paintedHeight + 3
  // }

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
        properties: "scale"; duration: 100;
        easing.type: Easing.InQuad
      }
    }
  ]
}
