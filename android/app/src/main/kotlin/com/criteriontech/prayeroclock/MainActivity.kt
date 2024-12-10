package com.criteriontech.prayeroclock

import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.widget.RemoteViews
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.criteriontech.prayer_o_clock/update_widget"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "updatePrayerWidget") {
                val prayerName = call.argument<String>("prayerName") ?: "Prayer"
                val time = call.argument<String>("time") ?: "00:00:00"
                val progress = call.argument<Int>("progress") ?: 0

                // Update the widget with the new values
                updatePrayerWidget(prayerName, time, progress)
                result.success("Widget updated successfully")
            } else {
                result.notImplemented()
            }
        }
    }

    private fun updatePrayerWidget(prayerName: String, time: String, progress: Int) {
        val views = RemoteViews(packageName, R.layout.widget_layout)
        views.setTextViewText(R.id.title, "Left for $prayerName")
        views.setTextViewText(R.id.time, time)
        views.setProgressBar(R.id.progress_bar, 100, progress, false)  // Update progress dynamically

        val appWidgetManager = AppWidgetManager.getInstance(this)
        val componentName = ComponentName(this, PrayerAppWidgetProvider::class.java)
        appWidgetManager.updateAppWidget(componentName, views)
    }
}
