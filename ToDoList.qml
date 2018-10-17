import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

import ToDo 1.0

ColumnLayout {
    Frame {
        Menu {
              id: contentMenu

              Action { text: qsTr("Tool Bar"); checkable: true }
              Action { text: qsTr("Side Bar"); checkable: true; checked: true }
              Action { text: qsTr("Status Bar"); checkable: true; checked: true }

              MenuSeparator {
                  contentItem: Rectangle {
                      implicitWidth: 200
                      implicitHeight: 1
                      color: "#21be2b"
                  }
              }

              Menu {
                  title: "Child Menu"
              }

              topPadding: 2
              bottomPadding: 2

              delegate: MenuItem {
                  id: menuItem
                  implicitWidth: 200
                  implicitHeight: 40

                  arrow: Canvas {
                      x: parent.width - width
                      implicitWidth: 40
                      implicitHeight: 40
                      visible: menuItem.subMenu
                      onPaint: {
                          var ctx = getContext("2d")
                          ctx.fillStyle = menuItem.highlighted ? "#ffffff" : "white"
                          ctx.moveTo(15, 15)
                          ctx.lineTo(width - 15, height / 2)
                          ctx.lineTo(15, height - 15)
                          ctx.closePath()
                          ctx.fill()
                      }
                  }

                  indicator: Item {
                      implicitWidth: 40
                      implicitHeight: 40
                      Rectangle {
                          width: 26
                          height: 26
                          anchors.centerIn: parent
                          visible: menuItem.checkable
                          border.color: "#21be2b"
                          radius: 3
                          Rectangle {
                              width: 14
                              height: 14
                              anchors.centerIn: parent
                              visible: menuItem.checked
                              color: "#21be2b"
                              radius: 2
                          }
                      }
                  }

                  contentItem: Text {
                      leftPadding: menuItem.indicator.width
                      rightPadding: menuItem.arrow.width
                      text: menuItem.text
                      font: menuItem.font
                      opacity: enabled ? 1.0 : 0.3
                      color: menuItem.highlighted ? "#ffffff" : "#21be2b"
                      horizontalAlignment: Text.AlignLeft
                      verticalAlignment: Text.AlignVCenter
                      elide: Text.ElideRight
                  }

                  background: Rectangle {
                      implicitWidth: 200
                      implicitHeight: 40
                      opacity: enabled ? 1 : 0.3
                      color: menuItem.highlighted ? "#21be2b" : "transparent"
                  }
              }

              background: Rectangle {
                  implicitWidth: 200
                  implicitHeight: 40
                  color: "#ffffff"
                  border.color: "#21be2b"
                  radius: 2
              }
          }

        ListView {
            implicitWidth: 250
            implicitHeight: 250
            clip: true
            anchors.fill: parent

            model: ToDoModel {
                list: toDoList
            }

            delegate: RowLayout {
                width: parent.width

                CheckBox {
                    checked: model.done
                    onClicked: model.done = checked
                }
                TextField {
                    id: textField
                    Layout.fillWidth: true
                    text: model.description
                    onEditingFinished: model.description = text
                    selectByMouse: true

                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.RightButton
                        onClicked: {
                            contentMenu.popup()
                        }
                    }
                }
            }
        }
    }

    RowLayout {
        Button {
            text: qsTr("Add new item")
            onClicked: toDoList.appendItem()
            Layout.fillWidth: true
        }
        Button {
            text: qsTr("Remove completed")
            onClicked: toDoList.removeCompletedItems()
            Layout.fillWidth: true
        }
    }
}
