from PyQt5.QtCore import pyqtProperty, pyqtSlot, pyqtSignal, QObject, Q_CLASSINFO
from PyQt5.QtQml import QQmlListProperty

import os

HEADER_SIZE = 21
PNG_HEADER = b'\x89PNG\r\n\x1a\n\x00\x00\x00\rIHDR\x00\x00'
JPG_HEADER = b'\xff\xd8\xff\xe0\x00\x10JFIF\x00\x01\x01\x01\x00`\x00`\x00\x00\xff'


class ImageDescriptor(QObject):
    sourceChanged = pyqtSignal()

    def __init__(self, parent=None):
        super(ImageDescriptor, self).__init__(parent)

        self.__source = ''

    @pyqtProperty(str, notify=sourceChanged)
    def source(self):
        return self.__source

    @source.setter
    def source(self, value):
        self.__source = value
        self.sourceChanged.emit()


class ImageLoader(QObject):
    Q_CLASSINFO('DeafaultProperty', 'images')

    def __init__(self, parent=None):
        super(ImageLoader, self).__init__(parent)

        self.__images = []

    @pyqtProperty(QQmlListProperty)
    def images(self):
        return QQmlListProperty(QObject, self, self.__images)

    @pyqtSlot(str)
    def load(self, source):
        directory = os.path.dirname(source)
        for archive in os.listdir(directory):
            fd = os.open(archive, os.O_RDONLY)

            header = os.read(fd, HEADER_SIZE)
            if header == JPG_HEADER or header[:-3] == PNG_HEADER:
                img = ImageDescriptor(self)
                img.source = archive
                self.__images.append(img)
