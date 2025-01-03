package com.criteriontech.prayeroclock

import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings
import android.os.PowerManager
import android.widget.RemoteViews
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.criteriontech.prayeroclock/update_widget"

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
            }
            else if (call.method == "disableBatteryOptimization"){
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    val pm = getSystemService(Context.POWER_SERVICE) as PowerManager
                    val packageName = packageName

                    if (pm.isIgnoringBatteryOptimizations(packageName)) {
                        result.success(true) // Battery optimization already disabled
                    } else {
                        val intent = Intent(Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS)
                        intent.data = Uri.parse("package:$packageName")
                        startActivity(intent)
                        result.success(false) // Request sent to disable battery optimization
                    }
                } else {
                    result.success(null) // Not applicable for versions below Android M
                }
            }
            else if (call.method == "enableAutostart") {
                val intent = Intent()
                try {
                    val manufacturer = Build.MANUFACTURER
                    when {
                        manufacturer.equals("xiaomi", ignoreCase = true) -> {
                            intent.component = ComponentName(
                                "com.miui.securitycenter",
                                "com.miui.permcenter.autostart.AutoStartManagementActivity"
                            )
                        }
                        manufacturer.equals("oppo", ignoreCase = true) -> {
                            intent.component = ComponentName(
                                "com.coloros.safecenter",
                                "com.coloros.safecenter.permission.startup.StartupAppListActivity"
                            )
                        }
                        manufacturer.equals("vivo", ignoreCase = true) -> {
                            intent.component = ComponentName(
                                "com.vivo.permissionmanager",
                                "com.vivo.permissionmanager.activity.BgStartUpManagerActivity"
                            )
                        }
                        manufacturer.equals("huawei", ignoreCase = true) -> {
                            intent.component = ComponentName(
                                "com.huawei.systemmanager",
                                "com.huawei.systemmanager.optimize.process.ProtectActivity"
                            )
                        }
                        manufacturer.equals("samsung", ignoreCase = true) -> {
                            intent.component = ComponentName(
                                "com.samsung.android.sm",
                                "com.samsung.android.sm.app.dashboard.SmartManagerDashBoardActivity"
                            )
                        }
                        manufacturer.equals("asus", ignoreCase = true) -> {
                            intent.component = ComponentName(
                                "com.asus.mobilemanager",
                                "com.asus.mobilemanager.entry.FunctionActivity"
                            )
                        }
                        else -> {
                            intent.action = Settings.ACTION_APPLICATION_DETAILS_SETTINGS
                            intent.data = Uri.fromParts("package", packageName, null)
                        }
                    }
                    startActivity(intent)
                    result.success("success")
                } catch (e: Exception) {
                    result.error("ERROR", "Failed to open autostart settings", e.message)
                }
            }

            else {
                result.notImplemented()
            }
        }
    }

    private fun updatePrayerWidget(prayerName: String, time: String, progress: Int) {
        val views = RemoteViews(packageName, R.layout.widget_layout)
        views.setTextViewText(R.id.title, "$prayerName")
        views.setTextViewText(R.id.time, time)
        views.setProgressBar(R.id.progress_bar, 100, progress, false)  // Update progress dynamically

        val appWidgetManager = AppWidgetManager.getInstance(this)
        val componentName = ComponentName(this, PrayerAppWidgetProvider::class.java)
        appWidgetManager.updateAppWidget(componentName, views)
    }
}
