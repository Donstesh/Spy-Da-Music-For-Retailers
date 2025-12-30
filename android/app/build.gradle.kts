plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.spy_damusic.spyda.spyda_music_retailer"
    compileSdk = 36
    ndkVersion = "27.0.12077973"

    // 🔥 CORRECT PLACEMENT: Move signingConfigs OUTSIDE compileOptions
    signingConfigs {
        create("release") {
            storeFile = file("E:/stesh/apk_key/spyda_music.jks")
            storePassword = "steshdev"
            keyAlias = "upload"
            keyPassword = "steshdev"
        }
    }

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.spy_damusic.spyda.spyda_music_retailer"
        minSdk = flutter.minSdkVersion
        targetSdk = 36
        versionCode = flutter.versionCode.toInt()
        versionName = flutter.versionName
        resConfigs(listOf("en", "xxhdpi"))

        // Enable multidex support
        multiDexEnabled = true
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = false  // Start with false, set to true for production
            isShrinkResources = false // Start with false, set to true for production
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
        getByName("debug") {
            // Flutter provides default debug signing
            isMinifyEnabled = false
            isDebuggable = true
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Core desugaring for Java 8+ APIs
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")

    // Kotlin stdlib
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8:1.9.22")

    // Material design
    implementation("com.google.android.material:material:1.11.0")

    // AppCompat for compatibility
    implementation("androidx.appcompat:appcompat:1.6.1")

    // Multidex support
    implementation("androidx.multidex:multidex:2.0.1")

    // Core KTX extensions
    implementation("androidx.core:core-ktx:1.12.0")
    implementation("androidx.core:core:1.12.0")

    // Activity KTX for lifecycle-aware components
    implementation("androidx.activity:activity-ktx:1.8.2")
    implementation("androidx.activity:activity:1.8.2")
    implementation("androidx.activity:activity-compose:1.8.2")

    // Fragment KTX
    implementation("androidx.fragment:fragment-ktx:1.6.2")

    // Browser for WebView/Chrome Custom Tabs
    implementation("androidx.browser:browser:1.7.0")

    // Optional: If you need in-app updates
    // implementation("com.google.android.play:app-update:2.1.0")
    // implementation("com.google.android.play:app-update-ktx:2.1.0")

    // Optional: If you need dynamic feature delivery
    // implementation("com.google.android.play:feature-delivery:2.1.0")
    // implementation("com.google.android.play:feature-delivery-ktx:2.1.0")

    // Optional: If you need Stripe payments
    // implementation("com.stripe:stripe-android:20.37.1")
}