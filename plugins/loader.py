from PyQt5.QtCore import pyqtProperty, pyqtSlot, pyqtSignal, QObject, Q_CLASSINFO
from PyQt5.QtQml import QQmlListProperty

import os

HEADER_SIZE = 21
PNG_HEADER = b'\x89PNG\r\n\x1a\n\x00\x00\x00\rIHDR\x00\x00'
JPG_HEADER = b'\xff\xd8\xff\xe0\x00\x10JFIF\x00\x01\x01\x01\x00`\x00`\x00\x00\xff'


class ImageDescriptor(QObject):
    nameChanged = pyqtSignal()

    def __init__(self, parent=None):
        super(ImageDescriptor, self).__init__(parent)

        self.__name = ''

    @pyqtProperty(str, notify=nameChanged)
    def name(self):
        return self.__name

    @name.setter
    def name(self, value):
        self.__name = value
        self.nameChanged.emit()


class ImageLoader(QObject):
    Q_CLASSINFO('DefaultProperty', 'images')

    def __init__(self, parent=None):
        super(ImageLoader, self).__init__(parent)

        self.__images = []

    @pyqtProperty(QQmlListProperty)
    def images(self):
        return QQmlListProperty(ImageDescriptor, self, self.__images)

    @pyqtSlot(str)
    def load(self, source):
        directory = os.path.dirname(source)
        for archive in os.listdir(directory):
            fd = os.open(archive, os.O_RDONLY)

            header = os.read(fd, HEADER_SIZE)
            if header == JPG_HEADER or header[:-3] == PNG_HEADER:
                img = ImageDescriptor(self)
                img.name = archive
                self.__images.append(img)
