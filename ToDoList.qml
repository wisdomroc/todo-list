import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

import ToDo 1.0

ColumnLayout {
    Frame {
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
                    Layout.fillWidth: true
                    text: model.description
                    onEditingFinished: model.description = text
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
