plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "eu.flutter.netguard"
    compileSdk = 35
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    defaultConfig {
        applicationId = "eu.flutter.netguard"

        minSdk = 22
        targetSdk = 35
        versionName = "0.1"
        versionCode = 1


        externalNativeBuild {
            cmake {
                cppFlags += ""
                arguments += listOf("-DANDROID_PLATFORM=android-22")
                // https://developer.android.com/ndk/guides/cmake.html
            }
        }

        //ndkVersion = "25.2.9519653"
        ndkVersion = "27.0.12077973"
        ndk {
            // https://developer.android.com/ndk/guides/abis.html#sa
            abiFilters += listOf("armeabi-v7a", "arm64-v8a", "x86", "x86_64")
        }
    }


    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = true
            proguardFiles.add(file("proguard-rules.pro"))
        }
        debug {
            isDebuggable = true
            isJniDebuggable = true
            isMinifyEnabled = true
            proguardFiles.add(file("proguard-rules.pro"))
        }
    }

    externalNativeBuild {
        cmake {
            path("CMakeLists.txt")
        }
    }

}

dependencies{
    implementation("androidx.preference:preference:1.2.1")
    implementation("androidx.localbroadcastmanager:localbroadcastmanager:1.1.0")
    //implementation("com.squareup.retrofit2:converter-jackson:2.11.0")
    implementation("com.fasterxml.jackson.core:jackson-databind:2.17.2")
    implementation("com.fasterxml.jackson.core:jackson-core:2.17.2")
    implementation("com.fasterxml.jackson.core:jackson-annotations:2.17.2")
}

flutter {
    source = "../.."
}
