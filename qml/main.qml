import QtQuick 2.4
import QtQuick.Window 2.2

import "ViewerCore"

Window {
  visible: true
  visibility: Window.Maximized
  title: "Wit"
  color: "#2a302d"

  ImageStrip {
    z: 1
    anchors {
      top: parent.bottom
      topMargin: -160
      bottom: parent.bottom
      horizontalCenter: parent.horizontalCenter
      horizontalCenterOffset: -120
    }
  }

  Item {
    anchors.fill: parent

    Image {
      id: viewer

      anchors.centerIn: parent
      antialiasing: true
      scale: 300 / Math.max(sourceSize.width, sourceSize.height)
    }
  }

  MouseArea {
    anchors.fill: parent

    onWheel: {
      if (wheel.modifiers & Qt.ControlModifier)
        viewer.rotation += wheel.angleDelta.y / 120 * 5;
      else
        viewer.scale += viewer.scale * wheel.angleDelta.y / 580;
    }
  }
}
