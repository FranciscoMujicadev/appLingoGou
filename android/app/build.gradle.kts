import java.util.Properties
import java.io.FileInputStream

// --- INICIO DEL CÓDIGO AGREGADO PARA LEER local.properties ---
val localProperties = Properties()
val localPropertiesFile = rootProject.file("local.properties")
if (localPropertiesFile.exists()) {
    localPropertiesFile.inputStream().use { stream ->
        localProperties.load(stream)
    }
}

val flutterVersionCode = localProperties.getProperty("flutter.versionCode") ?: "1"
val flutterVersionName = localProperties.getProperty("flutter.versionName") ?: "1.0"
// --- FIN DEL CÓDIGO AGREGADO ---

val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties()
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

plugins {
    id("com.android.application")
    // Conecta con Firebase Google Services
    id("com.google.gms.google-services")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    // Namespace corregido para coincidir con tu nuevo ID
    namespace = "com.avanza.lingogoucards"
    compileSdk = 36
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String
            keyPassword = keystoreProperties["keyPassword"] as String
            storeFile = file(keystoreProperties["storeFile"] as String)
            storePassword = keystoreProperties["storePassword"] as String
        }
    }

    defaultConfig {
        // Tu nuevo ID oficial que registramos en Firebase
        applicationId = "com.avanza.lingogoucards"
        minSdk = 24
        targetSdk = 36
        versionCode = flutterVersionCode.toInt()
        versionName = flutterVersionName

        multiDexEnabled = true

        manifestPlaceholders["admobAppId"] =
            System.getenv("ADMOB_APP_ID")
                ?: localProperties.getProperty("admob.appId")
                ?: ""
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
        }
    }
}

flutter {
    source = "../.."
}