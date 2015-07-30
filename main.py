#!/usr/bin/env python3
from PyQt5.QtCore import QVariant, QUrl
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import QQmlApplicationEngine
import resources_qrc

import os

HEADER_SIZE = 18
PNG_HEADER = b'\x89PNG\r\n\x1a\n\x00\x00\x00\rIHDR\x00\x00'
JPG_HEADER = b'\xff\xd8\xff'
GIF_HEADER = b'GIF89a'


def load(source):
    imgs = []
    index = 0
    # if dirname returns '' use the current directory
    directory = os.path.abspath(os.path.dirname(source) or '.')
    files = os.listdir(directory)
    for i in range(len(files)):
        archive = os.path.join(directory, files[i])
        if archive == source:
            index = i
        if os.path.isfile(archive):
            fd = os.open(archive, os.O_RDONLY)

            header = os.read(fd, HEADER_SIZE)
            # print(header)
            if PNG_HEADER in header or JPG_HEADER in header or GIF_HEADER in header:
                imgs.append(archive)
            os.close(fd)
    return imgs, index

if __name__ == '__main__':
    import sys
    app = QApplication(sys.argv)

    engine = QQmlApplicationEngine()
    engine.load(QUrl('qrc:/qml/main.qml'))

    addrs, index = load(' '.join(sys.argv[1:]))
    context = engine.rootContext()
    context.setContextProperty('sourceIndex', index)
    context.setContextProperty('imageModel', QVariant(sorted(addrs)))

    sys.exit(app.exec_())
