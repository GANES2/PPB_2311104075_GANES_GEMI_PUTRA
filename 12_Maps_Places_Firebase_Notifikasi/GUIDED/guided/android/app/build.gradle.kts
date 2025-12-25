/*
  File contoh untuk menegaskan minSdkVersion.
  Kalau project kamu pakai build.gradle (Groovy), tinggal samakan konsepnya.
*/
plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.praktikum12_maps_guided"
    compileSdk = 34

    defaultConfig {
        applicationId = "com.example.praktikum12_maps_guided"
        minSdk = 20
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }
}

flutter {
    source = "../.."
}
