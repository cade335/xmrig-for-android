package com.xmrigforandroid.workers

import android.content.Context
import android.util.Log
import androidx.work.CoroutineWorker
import androidx.work.WorkerParameters
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.RequestBody.Companion.toRequestBody
import java.io.IOException

class XMRigJsonRpcWorker(appContext: Context, workerParams: WorkerParameters):
        CoroutineWorker(appContext, workerParams) {

    private val client = OkHttpClient()

    override suspend fun doWork(): Result {
        return withContext(Dispatchers.IO) {
            val method = inputData.getString("METHOD") ?: return@withContext Result.failure()
            Log.d(XMRigJsonRpcWorker.LOG_TAG, "Sending JSON RPC to XMRig: $method")
            val requestBody = "{\"method\":\"$method\", \"id\": 1}"
            val request = Request.Builder()
                    .url("http://127.0.0.1:50080/json_rpc")
                    .post(requestBody.toRequestBody())
                    .addHeader("Content-Type", "application/json")
                    .addHeader("Authorization", "Bearer XMRigForAndroid")
                    .build()

            try {
                client.newCall(request).execute().use { response ->
                    if (!response.isSuccessful) {
                        Log.e(XMRigJsonRpcWorker.LOG_TAG, response.body.toString())
                        return@withContext Result.failure()
                    }
                    Result.success()
                }
            } catch (e: Exception) {
                Log.e(XMRigJsonRpcWorker.LOG_TAG, e.message.toString())
                Result.failure()
            }
        }
    }

    companion object {
        const val LOG_TAG = "XMRigJsonRpcWorker"
    }
}
