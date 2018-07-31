import VPlayApps 1.0
import VPlayPlugins 1.0
import QtQuick 2.0
import "helper"
import "pages"

Item {
    anchors.fill: parent

    // app content with plugin list
    NavigationStack {
        id: pluginMainItem

        // initial page contains list if plugins and opens pages for each plugin when selected
        ListPage {
            id: page
            title: qsTr("V-Play Plugins")

            model: ListModel {
                ListElement { type: "In-App Purchases"; name: "Soomla"
                    detailText: "In-App Purchases & Virtual Currency"; image: "../assets/logo-soomla.png" }
                ListElement { type: "Social"; name: "Facebook"
                    detailText: "Social Sharing & Friend Invites"; image: "../assets/logo-facebook.png" }
                ListElement { type: "Analytics"; name: "Flurry"
                    detailText: "User Analytics & App Statistics"; image: "../assets/logo-flurry.png" }
                ListElement { type: "Notifications"; name: "OneSignal Push Notifications"
                    detailText: "Targeted Push Notifications"; image: "../assets/logo-onesignal.png" }
                ListElement { type: "Notifications"; name: "Local Notifications"
                    detailText: "Schedule Local Notifications"; image: "../assets/logo-localpush.png" }
                ListElement { type: "Beta Testing & Crash Reporting"; name: "HockeyApp"
                    detailText: "Beta Distribution & Crash Reports"; image: "../assets/logo-hockey.png" }
            }

            delegate: PluginListItem {
                visible: name !== "GameCenter" || Theme.isIos

                onSelected: {
                    switch (name) {
                    case "Soomla":
                        page.navigationStack.push(soomlaPage)
                        break
                    case "Facebook":
                        page.navigationStack.push(facebookPage)
                        break
                    case "Flurry":
                        page.navigationStack.push(Qt.resolvedUrl("pages/FlurryPage.qml"))
                        break
                    case "OneSignal Push Notifications":
                        page.navigationStack.push(Qt.resolvedUrl("pages/OneSignalPage.qml"))
                        break
                    case "Local Notifications":
                        page.navigationStack.push(notificationPage)
                        break
                    case "HockeyApp":
                        page.navigationStack.push(Qt.resolvedUrl("pages/HockeyAppPage.qml"))
                        break
                    }
                }
            }

            section.property: "type"
            section.delegate: SimpleSection { }
        }
    }
}
