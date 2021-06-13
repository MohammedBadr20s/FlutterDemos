package com.example.msgraph

import android.os.Build
import android.util.Log
import androidx.annotation.RequiresApi
import com.microsoft.graph.authentication.IAuthenticationProvider
import com.microsoft.graph.concurrency.ICallback
import com.microsoft.graph.core.ClientException
import com.microsoft.graph.http.IHttpRequest
import com.microsoft.graph.models.extensions.DateTimeTimeZone
import com.microsoft.graph.models.extensions.IGraphServiceClient
import com.microsoft.graph.models.extensions.User
import com.microsoft.graph.options.Option
import com.microsoft.graph.options.QueryOption
import com.microsoft.graph.requests.extensions.GraphServiceClient
import com.microsoft.graph.requests.extensions.IContactCollectionPage
import com.microsoft.graph.requests.extensions.IEventCollectionPage
import com.microsoft.graph.requests.extensions.IMessageCollectionPage
import io.flutter.plugin.common.MethodChannel
import java.time.LocalDateTime
import java.time.ZoneId
import java.time.format.DateTimeFormatter
import java.time.format.FormatStyle
import java.util.*
import javax.ws.rs.core.Context


// Singleton class - the app only needs a single instance
// of the Graph client
class GraphHelper private constructor() : IAuthenticationProvider {
    private var mClient: IGraphServiceClient? = null
    private var mAccessToken: String? = null

    // Part of the Graph IAuthenticationProvider interface
    // This method is called before sending the HTTP request
    override fun authenticateRequest(request: IHttpRequest) {
        // Add the access token in the Authorization header
        request.addHeader("Authorization", "Bearer $mAccessToken")
    }

    fun getUser(accessToken: String?, callback: ICallback<User>) {
        mAccessToken = accessToken

        // GET /me (logged in user)
        mClient!!.me().buildRequest()[callback]
    }

    // <GetUserCallbackSnippet>
    fun getUserCallback(result: MethodChannel.Result, activity: MainActivity): ICallback<User> {
        return object : ICallback<User> {
            override fun success(user: User) {
                Log.d("AUTH", "User: " + user.displayName)
                var hashMap: HashMap<String, String> = HashMap<String, String>()
                hashMap["name"] = user.displayName ?: ""
                hashMap["email"] = if (user.mail == null) user.userPrincipalName else user.mail
                activity.runOnUiThread {
                    result.success(hashMap)
                }
            }

            override fun failure(ex: ClientException) {
                Log.e("AUTH", "Error getting /me", ex)
                activity.runOnUiThread {
                    result.error("UNAVAILABLE", ex.toString(), null)
                }
            }

        }
    } // </GetUserCallbackSnippet>

    // <GetEventsSnippet>
    fun getEvents(accessToken: String?, callback: ICallback<IEventCollectionPage>) {
        mAccessToken = accessToken

        // Use query options to sort by created time
        val options: MutableList<Option> = LinkedList()
        options.add(QueryOption("orderby", "createdDateTime DESC"))


        // GET /me/events
        mClient!!.me().events().buildRequest(options)
                .select("subject,organizer,start,end")[callback]
    }

    // </AddEventsToListSnippet>
    fun getEventsCallback(result: MethodChannel.Result, activity: MainActivity): ICallback<IEventCollectionPage> {
        return object : ICallback<IEventCollectionPage> {
            // <SuccessSnippet>
            override fun success(iEventCollectionPage: IEventCollectionPage) {
                var mapList: ArrayList<HashMap<String, String>> = ArrayList<HashMap<String, String>>()

                iEventCollectionPage.currentPage.map {
                    var hashMap: HashMap<String, String> = HashMap<String, String>()
                    hashMap["subject"] = it.subject
                    hashMap["organizer"] = it.organizer.emailAddress.address
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                        hashMap["duration"] = "${getLocalDateTimeString(it.start)} to ${getLocalDateTimeString(it.end)}"
                    }
                    mapList.add(hashMap)
                }

                activity.runOnUiThread {
                    result.success(mapList)

                }

            }

            // </SuccessSnippet>
            override fun failure(ex: ClientException) {
                Log.e("GRAPH", "Error getting events", ex)
                activity.runOnUiThread {
                    result.error("UNAVAILABLE", ex.toString(), null)
                }
            }
        }
    }

    @RequiresApi(Build.VERSION_CODES.O)
    private fun getLocalDateTimeString(dateTime: DateTimeTimeZone): String? {
        val localDateTime = LocalDateTime.parse(dateTime.dateTime)
                .atZone(ZoneId.of(dateTime.timeZone))
                .withZoneSameInstant(TimeZone.getDefault().toZoneId())
        return String.format("%s %s",
                localDateTime.format(DateTimeFormatter.ofLocalizedDate(FormatStyle.MEDIUM)),
                localDateTime.format(DateTimeFormatter.ofLocalizedTime(FormatStyle.SHORT)))
    }

    fun getEmails(accessToken: String?, callback: ICallback<IMessageCollectionPage>) {
        mAccessToken = accessToken

        // GET /me/mails
        mClient!!.me().messages().buildRequest()[callback]
    }

    // </AddMailsToListSnippet>
    fun getMailsCallback(result: MethodChannel.Result, activity: MainActivity): ICallback<IMessageCollectionPage> {
        return object : ICallback<IMessageCollectionPage> {
            // <SuccessSnippet>
            override fun success(IMessageCollectionPage: IMessageCollectionPage) {
                var mapList: ArrayList<HashMap<String, String>> = ArrayList<HashMap<String, String>>()

                IMessageCollectionPage.currentPage.map {
                    var hashMap: HashMap<String, String> = HashMap<String, String>()
                    hashMap["subject"] = it.subject
                    hashMap["sender"] = it.sender.emailAddress.address
                    hashMap["body"] = it.bodyPreview
                    mapList.add(hashMap)
                }
                activity.runOnUiThread {
                    result.success(mapList)

                }

            }

            // </SuccessSnippet>
            override fun failure(ex: ClientException) {
                Log.e("GRAPH", "Error getting Mails", ex)
                activity.runOnUiThread {
                    result.error("UNAVAILABLE", ex.toString(), null)
                }
            }
        }
    }

    fun getContacts(accessToken: String?, callback: ICallback<IContactCollectionPage>) {
        mAccessToken = accessToken

        // GET /me/mails
        mClient!!.me().contacts().buildRequest()[callback]
    }

    // </AddContactsToListSnippet>
    fun getContactsCallback(result: MethodChannel.Result, activity: MainActivity): ICallback<IContactCollectionPage> {
        return object : ICallback<IContactCollectionPage> {
            // <SuccessSnippet>
            override fun success(IContactCollectionPage: IContactCollectionPage) {
                var mapList: ArrayList<HashMap<String, String>> = ArrayList<HashMap<String, String>>()

                IContactCollectionPage.currentPage.map {
                    var hashMap: HashMap<String, String> = HashMap<String, String>()
                    hashMap["contactName"] = it.displayName
                    hashMap["mobile"] = it.mobilePhone
                    mapList.add(hashMap)
                }
                activity.runOnUiThread {
                    result.success(mapList)
                }
            }

            // </SuccessSnippet>
            override fun failure(ex: ClientException) {
                Log.e("GRAPH", "Error getting Contacts", ex)
                activity.runOnUiThread {
                    result.error("UNAVAILABLE", ex.toString(), null)
                }
            }
        }
    }


    // Debug function to get the JSON representation of a Graph
    // object
    fun serializeObject(`object`: Any): String {
        return mClient!!.serializer.serializeObject(`object`)
    } // </GetEventsSnippet>

    companion object {
        private var INSTANCE: GraphHelper? = null

        @get:Synchronized
        val instance: GraphHelper?
            get() {
                if (INSTANCE == null) {
                    INSTANCE = GraphHelper()
                }
                return INSTANCE
            }
    }

    init {
        mClient = GraphServiceClient.builder()
                .authenticationProvider(this).buildClient()
    }
}