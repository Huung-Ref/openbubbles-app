package com.bluebubbles.messaging.services

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build

class BootReciever : BroadcastReceiver() {

    override fun onReceive(context: Context, intent: Intent) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            context.startForegroundService(Intent(context, APNService::class.java))
        } else {
            context.startService(Intent(context, APNService::class.java))
        }
    }
}