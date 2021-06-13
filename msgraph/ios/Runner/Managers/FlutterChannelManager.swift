//
//  FlutterChannelManager.swift
//  Runner
//
//  Created by Mbadr on 07/06/2021.
//

import Foundation
import Flutter
import MSGraphClientModels

class FlutterChannelManager {
    static let shared = FlutterChannelManager()
    
    func receiveToken(parentView: UIViewController, result: @escaping FlutterResult) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            AuthenticationManager.instance.getTokenSilently {
                (token: String?, error: Error?) in
                
                DispatchQueue.main.async {
                    guard let data = token, error == nil else {
                        // If there is no token or if there's an error,
                        // no user is signed in, so stay here
                        let alert = UIAlertController(title: "Error signing in",
                                                      message: error.debugDescription,
                                                      preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        parentView.present(alert, animated: true)
                        result(FlutterError(code: "\(error?._code ?? 0)", message: error?.localizedDescription ?? "", details: nil))
                        return
                    }
                    print("Silent Token is \(data)")
                    result(data)
                }
            }
        }
        
    }
    
    func requestSignIn(parentView: UIViewController, result: @escaping FlutterResult) {
        AuthenticationManager.instance.getTokenInteractively(parentView: parentView) {
            (token: String?, error: Error?) in
            
            DispatchQueue.main.async {
                //                self.spinner.stop()
                
                guard let data = token, error == nil else {
                    // Show the error and stay on the sign-in page
                    let alert = UIAlertController(title: "Error signing in",
                                                  message: error.debugDescription,
                                                  preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    parentView.present(alert, animated: true)
                    result(FlutterError(code: "\(error?._code ?? 0)", message: error?.localizedDescription ?? "", details: nil))
                    return
                }
                print("Token is \(data)")
                // Signed in successfully
                result(data)
            }
        }
    }
    
    func getMyAccountData(parentView: UIViewController, result: @escaping FlutterResult) {
        GraphManager.instance.getMe {
            (user: MSGraphUser?, error: Error?) in
            
            DispatchQueue.main.async {
                guard let currentUser = user, error == nil else {
                    print("Error getting user: \(String(describing: error))")
                    let alert = UIAlertController(title: "Error getting User",
                                                  message: error.debugDescription,
                                                  preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    parentView.present(alert, animated: true)
                    result(FlutterError(code: "\(error?._code ?? 0)", message: error?.localizedDescription ?? "", details: nil))
                    return
                }
                let data = [
                    "name": currentUser.displayName ?? "Mysterious Stranger",
                    "email": currentUser.mail ?? currentUser.userPrincipalName ?? ""
                ]
                result(data)
                
            }
        }
    }
    
    func logout(result: @escaping FlutterResult) {
        AuthenticationManager.instance.signOut()
        result(true)
    }
    
    func getEvents(parentView: UIViewController, result: @escaping FlutterResult) {
        GraphManager.instance.getEvents {
            (eventArray: [MSGraphEvent]?, error: Error?) in
            DispatchQueue.main.async {
                guard let events = eventArray, error == nil else {
                    // Show the error
                    let alert = UIAlertController(title: "Error getting events",
                                                  message: error.debugDescription,
                                                  preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    parentView.present(alert, animated: true)
                    result(FlutterError(code: "\(error?._code ?? 0)", message: error?.localizedDescription ?? "", details: nil))
                    return
                }
                var eventsData = [[String: Any]]()
                let mappedEvents = events.map{ (item) -> [String: Any] in
                    let duration = "\(self.formatGraphDateTime(dateTime: item.start)) to \(self.formatGraphDateTime(dateTime: item.end))"

                    return [
                        "subject": item.subject ?? "",
                        "organizer": item.organizer?.emailAddress?.name ?? "",
                        "duration": duration
                    ]
                }
                eventsData = mappedEvents
                result(eventsData)
            }
        }
    }
    
    func getMessages(parentView: UIViewController, result: @escaping FlutterResult) {
        GraphManager.instance.getMessages { (messages: [MSGraphMessage]?, error: Error?) in
            DispatchQueue.main.async {
                guard let messages = messages, error == nil else {
                    // Show the error
                    let alert = UIAlertController(title: "Error getting Messages",
                                                  message: error.debugDescription,
                                                  preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    parentView.present(alert, animated: true)
                    result(FlutterError(code: "\(error?._code ?? 0)", message: error?.localizedDescription ?? "", details: nil))
                    return
                }
                var messagesData = [[String: Any]]()
                let mappedMessages = messages.map{ (item) -> [String: Any] in

                    return [
                        "subject": item.subject ?? "",
                        "sender": item.sender?.emailAddress?.address ?? "",
                        "body": item.bodyPreview ?? ""
                    ]
                }
                messagesData = mappedMessages
                result(messagesData)
            }
        }
    }
    
    func getContacts(parentView: UIViewController, result: @escaping FlutterResult) {
        GraphManager.instance.getContacts { (contacts: [MSGraphContact]?, error: Error?) in
            DispatchQueue.main.async {
                guard let contacts = contacts, error == nil else {
                    // Show the error
                    let alert = UIAlertController(title: "Error getting Contacts",
                                                  message: error.debugDescription,
                                                  preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    parentView.present(alert, animated: true)
                    result(FlutterError(code: "\(error?._code ?? 0)", message: error?.localizedDescription ?? "", details: nil))
                    return
                }
                var contactsData = [[String: Any]]()
                let mappedContacts = contacts.map{ (item) -> [String: Any] in
                    
                    return [
                        "contactName": item.displayName ?? "",
                        "mobile": item.mobilePhone ?? ""
                    ]
                }
                contactsData = mappedContacts
                result(contactsData)
            }
        }
    }
    private func formatGraphDateTime(dateTime: MSGraphDateTimeTimeZone?) -> String {
        guard let graphDateTime = dateTime else {
            return ""
        }
        
        // Create a formatter to parse Graph's date format
        let isoFormatter = DateFormatter()
        isoFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS"
        
        // Specify the timezone
        isoFormatter.timeZone = TimeZone(identifier: graphDateTime.timeZone!)
        
        let date = isoFormatter.date(from: graphDateTime.dateTime)
        
        // Output like 5/5/2019, 2:00 PM
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: date!)
    }
}
