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
} 