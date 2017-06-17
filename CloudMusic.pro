TEMPLATE = app

QT += qml quick
CONFIG += c++11

SOURCES += main.cpp \
    cpp/Network/network.cpp \
    cpp/audiodata.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    qml/TitleBar/TitleBar.qml \
    qml/main.qml \
    qml/TitleBar/TitleBarBtn.qml \
    qml/LeftWindow/LeftWindow.qml \
    qml/LeftWindow/ListItemBtn.qml \
    qml/BottomWindow/BtnPlay.qml \
    qml/BottomWindow/SliderPlay.qml \
    qml/BottomWindow/BottomWindow.qml \
    qml/RightWindow/DiscoverMusic/DiscoverMusic.qml \
    qml/RightWindow/DiscoverMusic/TabBtn.qml \
    qml/RightWindow/DiscoverMusic/Recommand/Recommand.qml \
    qml/RightWindow/DiscoverMusic/NetWorkError.qml \
    qml/RightWindow/DiscoverMusic/Loading.qml \
    qml/RightWindow/DiscoverMusic/Recommand/SongListItem.qml \
    qml/RightWindow/DiscoverMusic/Recommand/PrivateContentItem.qml \
    qml/RightWindow/DiscoverMusic/Recommand/NewSongItem.qml \
    qml/Utils/CustomMouseArea.qml \
    qml/RightWindow/Developing.qml \
    qml/TitleBar/SearchRect.qml \
    qml/RightWindow/SearchWindow/SearchWindow.qml \
    qml/RightWindow/SearchWindow/TabBtn.qml \
    qml/RightWindow/SearchWindow/Single.qml \
    qml/RightWindow/SearchWindow/SingleDelegate.qml \
    qml/RightWindow/LocalMusic/LocalMusic.qml \
    qml/RightWindow/LocalMusic/MusicList.qml \
    qml/RightWindow/LocalMusic/MusicListDelegate.qml \
    qml/SpectrumWindow/SpectrumWindow.qml \
    qml/SpectrumWindow/MiniWindow.qml \
    qml/SpectrumWindow/MaxWindow.qml \
    qml/BottomWindow/SoundEffect.qml \
    qml/BottomWindow/CustomSwitch.qml \
    qml/BottomWindow/CustomSlider.qml

RC_FILE = logo.rc

HEADERS += \
    cpp/Network/network.h \
    cpp/audiodata.h


#读取音乐文件信息，如作者、专辑等（libZPlay）
#win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../../../../libzplay-2.02-sdk/C++/ -llibzplay
#else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../../../../libzplay-2.02-sdk/C++/ -llibzplayd

#INCLUDEPATH += $$PWD/../../../../libzplay-2.02-sdk/C++
#DEPENDPATH += $$PWD/../../../../libzplay-2.02-sdk/C++

#win32:CONFIG(release, debug|release): LIBS += -L C:\libzplay-2.02-sdk\C++\ -llibzplay
#else:win32:CONFIG(debug, debug|release): LIBS += -L C:\libzplay-2.02-sdk\C++\ -llibzplayd

#INCLUDEPATH += C:\libzplay-2.02-sdk\C++
#LIBS += C:\libzplay-2.02-sdk\C++\libzplay.lib

win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../../../../../libzplay-2.02-sdk/C++/ -llibzplay
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../../../../../libzplay-2.02-sdk/C++/ -llibzplayd

INCLUDEPATH += $$PWD/../../../../../libzplay-2.02-sdk/C++
DEPENDPATH += $$PWD/../../../../../libzplay-2.02-sdk/C++

#win32:CONFIG(release, debug|release): LIBS += -L$$PWD/'../../../../Program Files/Python36/libs/' -lpython36
#else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/'../../../../Program Files/Python36/libs/' -lpython36d

#INCLUDEPATH += -I C:\Python27\include
#LIBS += -L C:\Python27\libs -lpython27

#win32:CONFIG(release, debug|release): LIBS += -LC:\python3\libs -lpython35
#else:win32:CONFIG(debug, debug|release): LIBS += -LC:\python3\libs -lpython35d

#INCLUDEPATH += C:\python3\libs
#DEPENDPATH += C:\python3\libs

