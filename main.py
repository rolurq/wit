#!/usr/bin/env python3
from PyQt5.QtCore import QVariant, QUrl
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import QQmlApplicationEngine
import resources_qrc

import os
import imghdr


def load(source):
    imgs = []
    index = 0
    # if dirname returns '' use the current directory
    directory = os.path.abspath(os.path.dirname(source) or '.')
    files = os.listdir(directory)
    i = 0
    for f in files:
        archive = os.path.join(directory, f)
        if archive == source:
            index = i
        if os.path.isfile(archive) and imghdr.what(archive):
            imgs.append(archive)
            i += 1
    return imgs, index

if __name__ == '__main__':
    import sys
    app = QApplication(sys.argv)

    engine = QQmlApplicationEngine()
    engine.load(QUrl('qrc:/qml/main.qml'))

    addrs, index = load(' '.join(sys.argv[1:]))
    context = engine.rootContext()
    context.setContextProperty('sourceIndex', index)
    context.setContextProperty('imageModel', QVariant(addrs))

    sys.exit(app.exec_())
