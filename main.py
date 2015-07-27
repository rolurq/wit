#!/usr/bin/env python3
from PyQt5.QtCore import QVariant, QUrl
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import QQmlApplicationEngine
import resources_qrc

import os

HEADER_SIZE = 18
PNG_HEADER = b'\x89PNG\r\n\x1a\n\x00\x00\x00\rIHDR\x00\x00'
JPG_HEADER = b'\xff\xd8\xff\xe0\x00\x10JFIF\x00\x01'


def load(source):
    imgs = []
    # if dirname returns '' use the current directory
    directory = os.path.abspath(os.path.dirname(source) or '.')
    for i in os.listdir(directory):
        archive = os.path.join(directory, i)
        if os.path.isfile(archive):
            fd = os.open(archive, os.O_RDONLY)

            header = os.read(fd, HEADER_SIZE)
            # print(header)
            if header == PNG_HEADER or header[:-6] == JPG_HEADER:
                imgs.append(archive)
            os.close(fd)
    return imgs

if __name__ == '__main__':
    import sys
    app = QApplication(sys.argv)

    engine = QQmlApplicationEngine()
    engine.load(QUrl('qrc:/qml/main.qml'))

    addrs = load(' '.join(sys.argv[1:]))
    # print(addrs)
    context = engine.rootContext()
    context.setContextProperty("imageModel", QVariant(addrs))

    sys.exit(app.exec_())
