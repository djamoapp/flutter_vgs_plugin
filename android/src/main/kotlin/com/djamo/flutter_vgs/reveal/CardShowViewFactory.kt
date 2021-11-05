package com.djamo.flutter_vgs.reveal

import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class CardShowViewFactory(private val messenger: BinaryMessenger? = null) :
        PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, id: Int, args: Any?): PlatformView {
        val vgsParams = args as Map<String?, Any?>?
        return CardShowFormView(context, messenger, id, vgsParams)
    }
}
