//package com.example.test

//import io.flutter.embedding.android.FlutterActivity

//class MainActivity : FlutterActivity()

package com.example.test

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

// Firebase imports
import com.google.firebase.FirebaseApp
import com.google.firebase.appcheck.debug.DebugAppCheckProviderFactory
import com.google.firebase.appcheck.FirebaseAppCheck

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Initialize Firebase
        FirebaseApp.initializeApp(this)

        // Enable Debug App Check Provider
        val firebaseAppCheck = FirebaseAppCheck.getInstance()
        firebaseAppCheck.installAppCheckProviderFactory(
            DebugAppCheckProviderFactory.getInstance()
        )
    }
}
