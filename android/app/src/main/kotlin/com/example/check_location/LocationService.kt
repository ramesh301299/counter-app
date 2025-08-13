package com.example.check_location

import android.app.Service
import android.content.Intent
import android.content.Context
import android.os.IBinder
import android.location.Location
import android.location.LocationListener
import android.location.LocationManager
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.os.Build
import android.util.Log

class LocationService : Service(), LocationListener {
    private lateinit var locationManager: LocationManager

    override fun onCreate() {
        super.onCreate()

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                "location_channel",
                "Location Service",
                NotificationManager.IMPORTANCE_DEFAULT
            )
            val manager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            manager.createNotificationChannel(channel)
        }

        val notification = Notification.Builder(this, "location_channel")
            .setContentTitle("Tracking Location")
            .setContentText("Running in background")
            .setSmallIcon(R.mipmap.ic_launcher)
            .build()

        startForeground(1, notification)

        locationManager = getSystemService(Context.LOCATION_SERVICE) as LocationManager
        locationManager.requestLocationUpdates(
            LocationManager.GPS_PROVIDER,
            5000L,
            10f,
            this
        )
    }

    override fun onLocationChanged(location: Location) {
        Log.d("LocationService", "Lat: ${location.latitude}, Lon: ${location.longitude}")
    }

    override fun onBind(intent: Intent?): IBinder? = null
}
