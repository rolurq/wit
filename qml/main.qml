import QtQuick 2.4
import QtQuick.Window 2.2

import "ViewerCore"

Window {
  visible: true
  visibility: Window.Maximized
  title: "Wit"
  color: "#2a302d"

  Item {
    anchors.fill: parent

    Image {
      id: viewer
      anchors.centerIn: parent
    }

    ImageStrip {
      z: 1
      anchors {
        top: parent.bottom
        topMargin: -150
        bottom: parent.bottom
        horizontalCenter: parent.horizontalCenter
        horizontalCenterOffset: -120
      }
    }
  }
}
