import QtQuick 2.4

Image {
    id: viewer

    property alias image: viewer.source

    anchors: {
        horizontalCenter: parent.horizontalCenter
        verticalCenter: parent.verticalCenter
    }
} 