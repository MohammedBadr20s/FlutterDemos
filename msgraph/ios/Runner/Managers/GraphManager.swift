//
//  GraphManager.swift
//  Runner
//
//  Created by Mbadr on 06/06/2021.
//

import MSGraphClientSDK
import MSGraphClientModels
// MARK: - selectedItemsObjWarningPhotoModel
struct PhotoModel: Codable {
    var odataContext, odataID: String?
    var odataMediaContentType, odataMediaEtag, id: String?
    var width, height: Int?

    enum CodingKeys: String, CodingKey {
        case odataContext = "@odata.context"
        case odataID = "@odata.id"
        case odataMediaContentType = "@odata.mediaContentType"
        case odataMediaEtag = "@odata.mediaEtag"
        case id, width, height
    }
}
class GraphManager {

    // Implement singleton pattern
    static let instance = GraphManager()

    private let client: MSHTTPClient?

    private init() {
        client = MSClientFactory.createHTTPClient(with: AuthenticationManager.instance)
    }

    public func getMe(completion: @escaping(MSGraphUser?, Error?) -> Void) {
        // GET /me
        let meRequest = NSMutableURLRequest(url: URL(string: "\(MSGraphBaseURL)/me")!)
        let meDataTask = MSURLSessionDataTask(request: meRequest, client: self.client, completion: {
            (data: Data?, response: URLResponse?, graphError: Error?) in
            guard let meData = data, graphError == nil else {
                completion(nil, graphError)
                return
            }

            do {
                // Deserialize response as a user
                let user = try MSGraphUser(data: meData)
                completion(user, nil)
            } catch {
                completion(nil, error)
            }
        })

        // Execute the request
        meDataTask?.execute()
    }
    func getPhoto( completion: @escaping(_ photo: Data?,_ error: Error?) -> Void) {
        let meRequest = NSMutableURLRequest(url: URL(string: "\(MSGraphBaseURL)/me/photo")!)
        let photoDataTask = MSURLSessionDataTask(request: meRequest, client: self.client, completion: {
            (data: Data?, response: URLResponse?, graphError: Error?) in
            guard let meData = data, graphError == nil else {
                completion(nil, graphError)
                return
            }

            do {
                // Deserialize response as a user
//                let photo = try JSONDecoder().decode(PhotoModel.self, from: meData)
                completion(meData, nil)
            } catch {
                completion(nil, error)
            }
        })
        // Execute the request
        photoDataTask?.execute()
    }
    
    // <GetEventsSnippet>
    public func getEvents(completion: @escaping([MSGraphEvent]?, Error?) -> Void) {
        // GET /me/events?$select='subject,organizer,start,end'$orderby=createdDateTime DESC
        // Only return these fields in results
        let select = "$select=subject,organizer,start,end"
        // Sort results by when they were created, newest first
        let orderBy = "$orderby=createdDateTime+DESC"
        let eventsRequest = NSMutableURLRequest(url: URL(string: "\(MSGraphBaseURL)/me/events?\(select)&\(orderBy)")!)
        let eventsDataTask = MSURLSessionDataTask(request: eventsRequest, client: self.client, completion: {
            (data: Data?, response: URLResponse?, graphError: Error?) in
            guard let eventsData = data, graphError == nil else {
                completion(nil, graphError)
                return
            }

            do {
                // Deserialize response as events collection
                let eventsCollection = try MSCollection(data: eventsData)
                var eventArray: [MSGraphEvent] = []

                eventsCollection.value.forEach({
                    (rawEvent: Any) in
                    // Convert JSON to a dictionary
                    guard let eventDict = rawEvent as? [String: Any] else {
                        return
                    }

                    // Deserialize event from the dictionary
                    let event = MSGraphEvent(dictionary: eventDict)!
                    eventArray.append(event)
                })

                // Return the array
                completion(eventArray, nil)
            } catch {
                completion(nil, error)
            }
        })

        // Execute the request
        eventsDataTask?.execute()
    }
    // </GetEventsSnippet>
    
    // <GetMessagesSnippet>
    public func getMessages(completion: @escaping([MSGraphMessage]?, Error?) -> Void) {

        let messagesRequest = NSMutableURLRequest(url: URL(string: "\(MSGraphBaseURL)/me/messages")!)
        let messagesDataTask = MSURLSessionDataTask(request: messagesRequest, client: self.client, completion: {
            (data: Data?, response: URLResponse?, graphError: Error?) in
            guard let messagesData = data, graphError == nil else {
                completion(nil, graphError)
                return
            }

            do {
                // Deserialize response as messages collection
                let messagesCollection = try MSCollection(data: messagesData)
                var messageArray: [MSGraphMessage] = []

                messagesCollection.value.forEach({
                    (rawEvent: Any) in
                    // Convert JSON to a dictionary
                    guard let messageDict = rawEvent as? [String: Any] else {
                        return
                    }

                    // Deserialize message from the dictionary
                    let message = MSGraphMessage(dictionary: messageDict)!
                    messageArray.append(message)
                })

                // Return the array
                completion(messageArray, nil)
            } catch {
                completion(nil, error)
            }
        })

        // Execute the request
        messagesDataTask?.execute()
    }
    // </GetMessagesSnippet>
    
    
    // <GetContactsSnippet>
    public func getContacts(completion: @escaping([MSGraphContact]?, Error?) -> Void) {

        let request = NSMutableURLRequest(url: URL(string: "\(MSGraphBaseURL)/me/contacts")!)
        let dataTask = MSURLSessionDataTask(request: request, client: self.client, completion: {
            (data: Data?, response: URLResponse?, graphError: Error?) in
            guard let contactsData = data, graphError == nil else {
                completion(nil, graphError)
                return
            }

            do {
                // Deserialize response as contacts collection
                let contactsCollection = try MSCollection(data: contactsData)
                var contactArray: [MSGraphContact] = []

                contactsCollection.value.forEach({
                    (rawEvent: Any) in
                    // Convert JSON to a dictionary
                    guard let contactDict = rawEvent as? [String: Any] else {
                        return
                    }

                    // Deserialize message from the dictionary
                    let contact = MSGraphContact(dictionary: contactDict)!
                    contactArray.append(contact)
                })

                // Return the array
                completion(contactArray, nil)
            } catch {
                completion(nil, error)
            }
        })

        // Execute the request
        dataTask?.execute()
    }
    // </GetContactsSnippet>
}
