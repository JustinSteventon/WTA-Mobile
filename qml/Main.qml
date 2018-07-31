import VPlayApps 1.0
import QtQuick 2.0
import "pages"
import "helper"

/*/////////////////////////////////////
  NOTE:
  Additional integration steps are needed to use V-Play Plugins, for example to add and link required libraries for Android and iOS.
  Please follow the integration steps described in the plugin documentation of your chosen plugins:
  - Soomla: https://v-play.net/doc/plugin-soomla/
  - Flurry: https://v-play.net/doc/plugin-flurry/
  - HockeyApp: https://v-play.net/doc/plugin-hockeyapp/
  - Facebook: https://v-play.net/doc/plugin-facebook/
  - OneSignal: https://v-play.net/doc/plugin-onesignal/
  - Local Notifications: https://v-play.net/doc/plugin-notification/

  To open the documentation of a plugin item in Qt Creator, place your cursor on the item in your QML code and press F1.
  This allows to view the properties, methods and signals of V-Play Plugins directly in Qt Creator.

/////////////////////////////////////*/

App {
    licenseKey: "EE48BD556B0333111A44B8B802A1B83D0BA99D081DFD80F6AECBD1E283C5A008B973DA1ED1CAB953F7178A699C0AC58F2D721362FFAB529AB4AC1A159F64DFD8094257FA05EC35212F8F7E01AF04D63C4D679BCD996DA8946D4D7DC8C5EF13DA2420320778EF959013B958BBA152D4B53B40C54DBB807686B7CB9C0EC86FD4A19A3FC4629F9636E6C0CED008A0CDB6524FADA59AE1015F14C68D73DE6470A7C371607AB92941736E3B0501149293666DC26F39CC6F93BBF144532B2B21E48AA1650890763681FEAD1C32987EB11B2258D95A72C6AA65EA7C6B9E0298A9C58BB902B21F4D4534037298647F5DC40A7C7BAC4F2C17239591C6AF3E1FDA4F68FB0609500D9065F9B69BD6C4B93EA60F47CB720E3F3629EEBB32EF211F748A27527AEC24059AED944C5AD4D05C6E18D5AE01A8FCEC422CB22CEE1B5BD5C05F24AA446866707F7B2319569E714D544741472707CC82445832CA285AD10A9B94EA2DC818E6BA9F658AE9A69A3A04417850F092C4284516114AE7E4F083C3BA4081F2F8AFD4D154CC45B3FF8B47167A78F40555F9FF9CFC9BA6921D42C9CDA4660CF7CCBDE9B2FD671321DF5BE438D3976B88F3D7F2287F86A1D755F917AA76B345F9F30B096D9AA4376EA378B36C727DA5B1F82D82FD649B9D50309566944867C5A25D5ED12D65A1F5A91199DB8329C69649792C340D807CA1D669C50FED7955469CA36588587D4F90117CAB1947E0D1A11DDDC5D0654CF1DA4055D14C4045684E9419"

    // This item contains example code for the chosen V-Play Plugins
    // It is hidden by default and will overlay the QML items below if shown
    PluginMainItem {
        id: pluginMainItem
        z: 2           // display the plugin example above other items in the QML code below
        visible: false // set this to true to show the plugin example

        // keep only one instance of these plugin-pages alive within app
        // this prevents crashes due to destruction of plugin items when popping pages from the stack
        property alias soomlaPage: soomlaPage
        property alias facebookPage: facebookPage
        property alias notificationPage: notificationPage

        SoomlaPage {
            id: soomlaPage
            visible: false
            onPushed: soomlaPage.listView.contentY = soomlaPage.listView.originY
            onPopped: { soomlaPage.parent = pluginMainItem; visible = false }
        }

        FacebookPage {
            id: facebookPage
            visible: false
            onPopped: { facebookPage.parent = pluginMainItem; visible = false }
        }

        LocalNotificationPage {
            id: notificationPage
            visible: false
            onPopped: { notificationPage.parent = pluginMainItem; visible = false }
        }
    }

    // property to store whether user is logged
    property bool userLoggedIn: false

    // login page is always visible if user is not logged in
    LoginPage {
        z: 1 // show login above actual app pages
        visible: opacity > 0
        enabled: visible
        opacity: userLoggedIn ? 0 : 1 // hide if user is logged in
        onLoginSucceeded: userLoggedIn = true

        Behavior on opacity { NumberAnimation { duration: 250 } } // page fade in/out
    }

    // navigation with actual app pages
    Navigation {
        id: nav
        enabled: userLoggedIn

        NavigationItem {
            title: "Main"
            icon: IconType.square

            NavigationStack {
                splitView: tablet
                MainPage {
                    onLogoutClicked: userLoggedIn = false
                }
            }
        } // navigation item

        NavigationItem {
            title: "Profile"
            icon: IconType.circle

            NavigationStack {
                ProfilePage {
                    onLogoutClicked: {
                        userLoggedIn = false
                        // jump to main page after logout
                        nav.currentIndex = 0
                        nav.currentNavigationItem.navigationStack.popAllExceptFirst()
                    }
                }
            }
        } // navigation item
    } // navigation
}
