package com.djamo.flutter_vgs.reveal
import android.util.Log
import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView
import android.graphics.Color
import android.view.View
import android.widget.TextView
import com.verygoodsecurity.vgsshow.VGSShow
import com.verygoodsecurity.vgsshow.core.network.client.VGSHttpMethod
import com.verygoodsecurity.vgsshow.widget.VGSTextView
import com.verygoodsecurity.vgsshow.core.VGSEnvironment
import com.verygoodsecurity.vgsshow.core.listener.VGSOnResponseListener
import com.verygoodsecurity.vgsshow.core.network.model.VGSResponse
import com.verygoodsecurity.vgsshow.core.network.model.VGSRequest
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

internal class CardShowFormView(context: Context,messenger: BinaryMessenger?, id: Int, vgsParams: Map<String?, Any?>? ): PlatformView,MethodCallHandler {
    var vaultId= vgsParams!!.get("vaultId")!!.toString();
    var environment= vgsParams!!.get("environment")!!.toString();
    var path= vgsParams!!.get("path")!!.toString();

    private val vgsShow : VGSShow = VGSShow.Builder(context, vaultId)
    .setEnvironment(if(environment == "live")VGSEnvironment.Live() else VGSEnvironment.Sandbox())
    .build()
    private val vgsTextView: VGSTextView = VGSTextView(context)

    protected val methodChannel = MethodChannel(messenger, "com.djamo.flutter_vgs/textview_$id".also {
        Log.d("Test", it)
    })

    override fun getView(): View {
        return vgsTextView
    }

    override fun dispose() {
        vgsShow.onDestroy()
    }

    init {
        var id= vgsParams!!.get("id")!!.toString();
         vgsTextView.setContentPath(id)
        vgsTextView.setHint("Fetching $id...")
        vgsShow.subscribe(vgsTextView) 
        methodChannel.setMethodCallHandler(this)

       
    }

    

     override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {

        when (call.method) {
            "revealVGSText" -> revealVGSText(call, result)
            "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
        }
    }
    
    private fun revealVGSText(call: MethodCall, result: MethodChannel.Result) {
        var id:String? = call.argument<String>("id");
        var token:String? = call.argument<String>("token");
        var path:String? = call.argument<String>("path");
       Log.d("Test", (call.arguments as Map<String,Any>).toString())
       if(path !== null){
           vgsShow.requestAsync(
        VGSRequest.Builder(path, VGSHttpMethod.POST)
                .body( mapOf(
                    id.toString() to token.toString()
            ))
                .build())  
                result.success(null)
       }
    
        }
    } 
