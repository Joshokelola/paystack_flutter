package com.paystack.paystack_flutter

import android.util.Log
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleEventObserver
import com.paystack.android.core.Paystack
import com.paystack.android.ui.paymentsheet.PaymentSheet
import com.paystack.android.ui.paymentsheet.PaymentSheetResult
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.embedding.engine.plugins.lifecycle.HiddenLifecycleReference
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class PaystackFlutterPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  private lateinit var channel : MethodChannel
  private lateinit var paymentSheet: PaymentSheet
  private var activity: FlutterFragmentActivity? = null

  private fun initializePaystack(publicKey: String, enableLogging: Boolean) {
    Paystack
      .builder()
      .setPublicKey(publicKey)
      .setLoggingEnabled(enableLogging)
      .build()
  }

  private fun launch(accessCode: String) {
    paymentSheet.launch(accessCode)
  }

  // TODO: Change return from String to PaymentSheetResult
  // This will require create the same response model in Flutter
  private fun paymentComplete(paymentSheetResult: PaymentSheetResult): String {
    val response = when (paymentSheetResult) {
      is PaymentSheetResult.Cancelled -> "Cancelled"
      is PaymentSheetResult.Failed -> paymentSheetResult.error.message ?: "Failed"
      is PaymentSheetResult.Completed -> {
        paymentSheetResult.paymentCompletionDetails.reference
      }
    }

    return response
  }

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "paystack_flutter")
    channel.setMethodCallHandler(this)
  }

  // TODO: Return object in result as opposed to String
  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
      "build" -> {
        initializePaystack(
          call.argument("publicKey") ?: "",
          call.argument("enableLogging") ?: false)
        result.success("Initiated")
      }
      "launch" -> {
        launch(call.argument("accessCode") ?: "")
        result.success("Launch called")
      }
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity as FlutterFragmentActivity
    Log.d("ACTIVITY: ", "Attached")
    (binding.lifecycle as HiddenLifecycleReference)
      .lifecycle
      .addObserver(LifecycleEventObserver { _, event ->
        if (event == Lifecycle.Event.ON_CREATE) {
          Log.d("OBSERVER: ", "In observer")
          val activity = requireNotNull(activity)
          paymentSheet = PaymentSheet(activity, ::paymentComplete)
        }
      })
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity as FlutterFragmentActivity
  }

  override fun onDetachedFromActivity() {
    activity = null
  }
}
