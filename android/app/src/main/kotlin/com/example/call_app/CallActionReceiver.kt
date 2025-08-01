package com.example.call_app

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.app.NotificationManager

class CallActionReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        val notificationManager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

        when (intent.action) {
            "ACTION_ANSWER_CALL" -> {
                notificationManager.cancel(1001)
                // Handle answer call action
            }
            "ACTION_DECLINE_CALL" -> {
                notificationManager.cancel(1001)
                // Handle decline call action
            }
        }
    }
}