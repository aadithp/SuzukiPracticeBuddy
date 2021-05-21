package spb.piano.app;

import android.graphics.drawable.Drawable;


import io.flutter.embedding.android.DrawableSplashScreen;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.android.SplashScreen;

public class MainActivity extends FlutterActivity {
    @Override
    public SplashScreen provideSplashScreen() {
        // Load the splash Drawable.
        Drawable splash = getResources().getDrawable(R.drawable.launch_background);

        // Construct a DrawableSplashScreen with the loaded splash
        // Drawable and return it.
        return new DrawableSplashScreen(splash);
    }
}
