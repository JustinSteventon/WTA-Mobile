import VPlayApps 1.0
import QtQuick 2.0

Page {
    id: mainPage
    title: "Main Page"

    signal logoutClicked()

    AppListView {
        model: ListModel {
            ListElement { name: "Banana" }
            ListElement { name: "Apple" }
            ListElement { name: "Potato" }
        }
        delegate: SimpleRow {
            text: name
            onSelected: navigationStack.popAllExceptFirstAndPush(detailPageComponent, {title: name})
        }
    }

    // component for detail page (opened when item of AppListView is selected)
    Component {
        id: detailPageComponent

        Page {
            id: detailPage

            AppButton {
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: dp(12)
                text: "Logout"
                flat: true
                onClicked: mainPage.logoutClicked()
            }

            Column {
                anchors.centerIn: parent
                spacing: dp(12)

                AppText {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: detailPage.title
                    font.pixelSize: sp(18)
                }

                AppButton {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Push another"
                    flat: false
                    onClicked: navigationStack.push(detailPageComponent, { title: "Sub-" + detailPage.title})
                }

                AppButton {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Return to previous page"
                    flat: true
                    onClicked: navigationStack.pop()
                }
            }
        }
    }// DetailPageComponent
}
