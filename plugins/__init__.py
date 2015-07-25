from PyQt5.QtQml import qmlRegisterType

from loader import ImageDescriptor, ImageLoader

MAJOR_VER = 1
MINOR_VER = 0

qmlRegisterType(ImageDescriptor, MAJOR_VER, MINOR_VER, 'ImageDescriptor')
qmlRegisterType(ImageLoader, MAJOR_VER, MINOR_VER, 'ImageLoader')
