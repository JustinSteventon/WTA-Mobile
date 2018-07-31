pragma Singleton

import QtQuick 2.0

Item {

    // Flurry
    readonly property string flurryApiKey: "XFWVMRHVKKGTM2J28W49"

    // HockeyApp
    readonly property string hockeyAppiOSAppid: "4c7c268551884a00801f504180d9c131"
    readonly property string hockeyAppAndroidAppid: "a2e24fcaeaa64741b8d169a35624c276"

    // OneSignal
    readonly property string oneSignalAppId: "a23e646c-0d6f-4611-836e-5bf14ee96e98"  // Not yet set
    readonly property string oneSignalGoogleProjectNumber: "522591647137"            // Not yet set

    // Soomla
    property string soomlaSecret: "<your-game-secret>"
    property string soomlaAndroidPublicKey: "<android-public-key>"
    property string creditsCurrencyItemId: "net.vplay.demos.PluginDemo.credits"
    property string creditsPackItemId: "net.vplay.demos.PluginDemo.creditspack"
    property string goodieItemId: "net.vplay.demos.PluginDemo.goodie"
    property string noAdsItemId: "net.vplay.demos.PluginDemo.noads"

    // Facebook
    property string facebookAppId: "285618998879854"

}
