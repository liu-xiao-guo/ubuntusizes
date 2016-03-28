import QtQuick 2.4
import Ubuntu.Components 1.3
import QtQuick.Window 2.2

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "ubuntusizes.xiaoguo"

    width: units.gu(60)
    height: units.gu(85)

    property string fontsize: listview.currentItem.fontsize
    property var orientations: ["PrimaryOrientation", "PortraitOrientation",
        "LandscapeOrientation","", "InvertedPortraitOrientation","", "","",
        "InvertedLandscapeOrientation" ]

    Component {
        id: highlightBar
        Rectangle {
            width: 200; height: 50
            color: "#FFFF88"
            y: listview.currentItem.y;
            Behavior on y { SpringAnimation { spring: 2; damping: 0.1 } }
        }
    }

    Page {
        title: i18n.tr("Ubuntu Sizes")

        Rectangle {
            id: rect
            anchors.fill: parent

            Component.onCompleted: {
                client.text = "client area width: " + rect.width/units.gu(1) + "gu height: " + rect.height/units.gu(1) + "gu"
            }

            onWidthChanged: {
                clientgu.text = "client area width: " + Math.round(rect.width/units.gu(1)) + "gu height: " + Math.round(rect.height/units.gu(1)) + "gu"
                client.text = "client area (" + rect.width + ", " + height + ")"
            }

            onHeightChanged: {
                client.text = "client area (" + rect.width + ", " + height + ")"
                clientgu.text = "client area width: " + Math.round(rect.width/units.gu(1)) + "gu height: " + Math.round(rect.height/units.gu(1)) + "gu"
            }
        }

        Flickable {
            anchors.fill: parent
            contentHeight:content.childrenRect.height

            Column {
                id: content
                anchors.fill: parent
                spacing: units.gu(1)

                Text {
                    id: unitsgu
                    text: "1 units.gu = " + units.gu(1) + " pixels"
                }

                Label {
                    text: "desktopAvailableHeight: " + Screen.desktopAvailableHeight
                }

                Label {
                    text: "devicePixelRatio: " + Screen.devicePixelRatio
                }

                Label {
                    text: "desktopAvailableWidth: " + Screen.desktopAvailableWidth
                }

                Label {
                    text: "Screen height: " + Screen.height
                }

                Label {
                    text: "Sreen width: " + Screen.width
                }

                Label {
                    text: "orientation: " + orientations[Screen.orientation]
                }

                Label {
                    text: "primaryOrientation: " + orientations[Screen.primaryOrientation]
                }

                Label {
                    text: "orientationUpdateMask: " + Screen.orientationUpdateMask
                }

                Label {
                    text: "pixelDensity: " + Screen.pixelDensity
                }

                Label {
                    id: info
                    text: "screen width: " + Math.round(Screen.width/units.gu(1)) + "gu  height: " + Math.round(Screen.height/units.gu(1)) + "gu"
                }

                Label {
                    id: clientgu
                }

                Label {
                    id: client
                }

                Label {
                    text: "1 dp = " + units.dp(1) + " pixels"
                }

                Row {
                    spacing: units.gu(1)

                    Label {
                        id: mylabel
                        anchors.verticalCenter: parent.verticalCenter
                        text: "I love"
                        fontSize: fontsize
                    }

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        text: mylabel.fontSize
                    }

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        text: mylabel.font.pixelSize + " pixels"
                    }

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        text: (mylabel.font.pixelSize/units.gu(1)).toFixed(2)+ " units.gu"
                    }
                }

                Row {
                    width: parent.width

                    Label {
                        width: parent.width/2
                        text: "Font Size"
                        font.bold: true
                        fontSize: "large"

                    }

                    Label {
                        width: parent.width/2
                        text: "ModularScale"
                        font.bold: true
                        fontSize: "large"
                    }

                }

                ListView {
                    id: listview
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width
                    // height: parent.height - mylabel.height
                    height: units.gu(20)
                    highlight: highlightBar
                    model: ["xx-small","x-small", "small", "medium", "large", "x-large" ]
                    delegate: Item {
                        width: listview.width
                        height: layout.height
                        property string fontsize: modelData

                        Row {
                            id: layout
                            width: parent.width

                            Label {
                                width: parent.width/2
                                text: modelData
                                fontSize: "large"
                            }

                            Label {
                                width: parent.width/2
                                text: (FontUtils.modularScale(modelData)).toFixed(2)
                                fontSize: "large"
                            }

                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                listview.currentIndex = index
                            }
                        }
                    }
                }
            }
        }
    }
}

