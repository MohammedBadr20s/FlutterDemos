package com.example.msgraph


import android.util.Log
import androidx.annotation.NonNull
import com.microsoft.identity.client.*
import com.microsoft.identity.client.IPublicClientApplication.ISingleAccountApplicationCreatedListener
import com.microsoft.identity.client.exception.MsalException
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {
    private val CHANNEL = "ms_graph"
    private val SCOPES = arrayOf("Files.Read")

    /* Azure AD v2 Configs */
    val AUTHORITY = "https://login.microsoftonline.com/common"
    private var mSingleAccountApp: ISingleAccountPublicClientApplication? = null

    private val TAG = MainActivity::class.java.simpleName
    var token = ""
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            PublicClientApplication.createSingleAccountPublicClientApplication(applicationContext,
                    R.raw.auth_config_single_account, object : ISingleAccountApplicationCreatedListener {
                override fun onCreated(application: ISingleAccountPublicClientApplication) {
                    mSingleAccountApp = application
                    when (call.method) {
                        "getInterActiveToken" -> signIn(result)
                        "getSilentToken" -> getSilentToken(result)
                        "getMe" -> getUser(result)
                        "getEvents" -> getEvents(result)
                        "getEmails" -> getMails(result)
                        "getContacts" -> getContacts(result)
                        "logout" -> signOut(result)
                        else -> {
                            result.notImplemented()
                        }
                    }
                }

                override fun onError(exception: MsalException) {
                    print(exception.toString())
                }
            })


        }
    }

    private fun signIn(result:  MethodChannel.Result) {
        if (mSingleAccountApp == null) {
            return
        }
        mSingleAccountApp!!.signIn(this@MainActivity, null, SCOPES, getAuthInteractiveCallback(result))
    }

    private fun signOut(result: MethodChannel.Result) {

        if (mSingleAccountApp == null) {
            return
        }
        mSingleAccountApp!!.signOut(object : ISingleAccountPublicClientApplication.SignOutCallback {
            override fun onSignOut() {
                result.success("signedOut")
            }

            override fun onError(exception: MsalException) {
                result.error("UNAVAILABLE", exception.toString(), null)
            }
        })
    }
    private fun getEvents(result: MethodChannel.Result) {

        GraphHelper.instance?.getEvents(token, GraphHelper.instance!!.getEventsCallback(result, this))
    }


    private fun getMails(result: MethodChannel.Result) {

        GraphHelper.instance?.getEmails(token, GraphHelper.instance!!.getMailsCallback(result, this))
    }

    private fun getContacts(result: MethodChannel.Result) {

        GraphHelper.instance?.getContacts(token, GraphHelper.instance!!.getContactsCallback(result, this))
    }



    private fun getUser(result: MethodChannel.Result) {
            // Get Graph client and get user
            GraphHelper.instance?.getUser(token, GraphHelper.instance!!.getUserCallback(result, this))
    }



    private fun getSilentToken(result: MethodChannel.Result) {
        if (mSingleAccountApp == null) {
            return
        }
        mSingleAccountApp!!.acquireTokenSilentAsync(SCOPES, AUTHORITY, getAuthSilentCallback(result))

    }
    private fun getAuthSilentCallback(result: MethodChannel.Result): SilentAuthenticationCallback {
        return object : SilentAuthenticationCallback {
            override fun onSuccess(authenticationResult: IAuthenticationResult) {
                Log.d(TAG, "Successfully authenticated")

                token = authenticationResult.accessToken
                result.success(authenticationResult.accessToken)
            }

            override fun onError(exception: MsalException) {
                Log.d(TAG, "Authentication failed: $exception")
                result.error("UNAVAILABLE", "$exception","")
            }
        }
    }

    private fun getAuthInteractiveCallback(result:  MethodChannel.Result): AuthenticationCallback {
        return object : AuthenticationCallback {
            override fun onSuccess(authenticationResult: IAuthenticationResult) {
                /* Successfully got a token, use it to call a protected resource - MSGraph */
                Log.d(TAG, "Successfully authenticated")
                token = authenticationResult.accessToken
                result.success(authenticationResult.accessToken)
            }

            override fun onError(exception: MsalException) {
                /* Failed to acquireToken */
                Log.d(TAG, "Authentication failed: $exception")
                result.error("UNAVAILABLE", "$exception","")
            }

            override fun onCancel() {
                /* User canceled the authentication */
                Log.d(TAG, "User cancelled login.")
                result.error("User cancelled login.", "$TAG","")
            }
        }

    }

}

