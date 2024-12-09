package com.criteriontech.prayeroclock

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews

class PrayerAppWidgetProvider : AppWidgetProvider() {

    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray) {
        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId)
        }
    }

    private fun updateAppWidget(context: Context, appWidgetManager: AppWidgetManager, appWidgetId: Int) {
        val views = RemoteViews(context.packageName, R.layout.widget_layout)

        // Placeholder values; these will be set by Flutter via MainActivity
        views.setTextViewText(R.id.title, "Left for Prayer")
        views.setTextViewText(R.id.time, "00:00:00")
        views.setProgressBar(R.id.progress_bar, 100, 0, false)

        appWidgetManager.updateAppWidget(appWidgetId, views)
    }
}
