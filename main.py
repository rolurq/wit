from PyQt5.QtCore import QUrl
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import QQmlApplicationEngine

import resources_qrc
import plugins

if __name__ == '__main__':
    import sys
    app = QApplication(sys.argv)

    engine = QQmlApplicationEngine()
    engine.load(QUrl('qrc:/qml/main.qml'))

    sys.exit(app.exec_())
