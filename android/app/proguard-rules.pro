-dontwarn androidx.window.extensions.WindowExtensions
-dontwarn androidx.window.extensions.WindowExtensionsProvider
-dontwarn androidx.window.extensions.area.ExtensionWindowAreaPresentation
-dontwarn androidx.window.extensions.layout.DisplayFeature
-dontwarn androidx.window.extensions.layout.FoldingFeature
-dontwarn androidx.window.extensions.layout.WindowLayoutComponent
-dontwarn androidx.window.extensions.layout.WindowLayoutInfo
-dontwarn androidx.window.sidecar.SidecarDeviceState
-dontwarn androidx.window.sidecar.SidecarDisplayFeature
-dontwarn androidx.window.sidecar.SidecarInterface$SidecarCallback
-dontwarn androidx.window.sidecar.SidecarInterface
-dontwarn androidx.window.sidecar.SidecarProvider
-dontwarn androidx.window.sidecar.SidecarWindowLayoutInfo
-dontwarn java.beans.ConstructorProperties
-dontwarn java.beans.Transient


# JACKSON / JSON
-keep class com.fasterxml.jackson.** { *; }
-keepattributes *Annotation*


#Line numbers
-renamesourcefileattribute SourceFile
-keepattributes SourceFile,LineNumberTable

#NetGuard
-keepnames class eu.flutter.netguard.** { *; }
-keep class eu.flutter.netguard.** { *; }

#JNI
-keepclasseswithmembernames class * {
    native <methods>;
}
-keepclassmembers class * {
    native <methods>;
}

#JNI callbacks
-keep class eu.flutter.netguard.MyVpnService {
    void nativeExit(java.lang.String);
    void nativeError(int, java.lang.String);
    void logPacket(eu.flutter.netguard.NativeBridge$Packet);
    void dnsResolved(eu.flutter.netguard.NativeBridge$ResourceRecord);
    boolean isDomainBlocked(int, java.lang.String);
    int getUidQ(int, int, java.lang.String, int, java.lang.String, int);
    boolean isAddressAllowed(eu.flutter.netguard.NativeBridge$Packet);
    void accountUsage(eu.flutter.netguard.NativeBridge$Usage);
}