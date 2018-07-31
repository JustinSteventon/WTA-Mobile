import VPlayApps 1.0

Page {
    title: "Profile Page"

    signal logoutClicked

    AppButton {
        anchors.centerIn: parent
        text: "Logout"
        onClicked: logoutClicked()
    }
}
