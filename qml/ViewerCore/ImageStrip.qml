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
        source: 'file://' + modelData
        opacity: wrapper.PathView.isCurrentItem ? 1 : .4

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
}