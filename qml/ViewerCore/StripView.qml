import QtQuick 2.4

PathView {
  id: view

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