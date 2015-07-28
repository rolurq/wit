import QtQuick 2.4
import QtQuick.Window 2.2

import "ViewerCore"
import "/js/script.js" as Script

Window {
  id: window

  visible: true
  visibility: Window.Maximized
  title: "Wit"
  color: "#96000000"

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
    anchors.centerIn: parent
    width: viewer.implicitWidth
    height: viewer.implicitHeight

    Image {
      id: viewer

      transformOrigin: Item.Center
      antialiasing: true
      fillMode: Image.PreserveAspectFit
      // scale the image to fit the screen
      scale: Script.calculateScale(sourceSize.width, sourceSize.height)

      MouseArea {
        anchors.fill: parent
        cursorShape: Qt.OpenHandCursor
        drag.target: viewer
        
        onPressed: cursorShape = Qt.ClosedHandCursor
        onReleased: cursorShape = Qt.OpenHandCursor
      }
    }
  }

  MouseArea {
    z: -1  // keep zoom/rotate area in the back of the image
    anchors.fill: parent

    onWheel: {
      if (wheel.modifiers & Qt.ControlModifier)
        viewer.rotation += wheel.angleDelta.y / 120 * 5;
      else
        viewer.scale += viewer.scale * wheel.angleDelta.y / 580;
    }
  }
}
