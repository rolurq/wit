import QtQuick 2.4

Rectangle {
  // width: 240; 
  // height: 200
  // color: "red"

  Component {
    id: delegate
    Column {
      id: wrapper
      ImageViewer {
        id: image
        width: 64; height: 64
        source: modelData
        opacity: wrapper.PathView.isCurrentItem ? 1 : .4

        states: State {
          when: wrapper.PathView.isCurrentItem
          PropertyChanges {target: viewer; source: modelData}
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
      // startX: 0; startY: 0
      startX: 120; startY: 100
      // PathQuad {x: 0; y: 100; controlX: view.count*50; controlY: 0}
      // PathQuad { x: 200; y: 0; controlX: 100; controlY: 150 }
      // PathQuad {x: -view.count*50; y: 100; controlX: 0; controlY: 0}
      PathQuad { x: 120; y: 25; controlX: view.count*26; controlY: 75 }
      PathQuad { x: 120; y: 100; controlX: -view.count*20; controlY: 75 }
    }
    
    Keys.onLeftPressed: decrementCurrentIndex()
    Keys.onRightPressed: incrementCurrentIndex()
  }
}