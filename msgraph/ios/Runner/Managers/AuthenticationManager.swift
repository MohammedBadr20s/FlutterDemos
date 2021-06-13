//
//  AuthenticationManager.swift
//  Runner
//
//  Created by Mbadr on 06/06/2021.
//

import MSAL
import MSGraphClientSDK

// Implement the MSAuthenticationProvider interface so
// this class can be used as an auth provider for the Graph SDK
class AuthenticationManager: NSObject, MSAuthenticationProvider {

    // Implement singleton pattern
    static let instance = AuthenticationManager()
    // Update the below to your client ID you received in the portal. The below is for running the demo only
    let kClientID: String
    let kGraphEndpoint = "https://graph.microsoft.com/" // the Microsoft Graph endpoint
    let kAuthority = "https://login.microsoftonline.com/common" // this authority allows a personal Microsoft account and a work or school account in any organization's Azure AD tenant to sign in
    var accessToken = String()
    private let publicClient: MSALPublicClientApplication?
    private let graphScopes: Array<String>

    private override init() {
        // Get app ID and scopes from AuthSettings.plist
        let bundle = Bundle.main
        let authConfigPath = bundle.path(forResource: "AuthSettings", ofType: "plist")!
        let authConfig = NSDictionary(contentsOfFile: authConfigPath)!

        self.kClientID = authConfig["AppId"] as! String
        self.graphScopes = authConfig["GraphScopes"] as! Array<String>

        do {
            guard let authorityURL = URL(string: kAuthority) else {
                print("Unable to create authority URL")
//                self.updateLogging(text: "Unable to create authority URL")
                self.publicClient = nil
                return
            }

            let authority = try MSALAADAuthority(url: authorityURL)

            let msalConfiguration = MSALPublicClientApplicationConfig(clientId: self.kClientID, redirectUri: nil, authority: authority)
            // Create the MSAL client
            try self.publicClient = MSALPublicClientApplication(configuration: msalConfiguration)
        } catch {
            print("Error creating MSAL public client: \(error)")
            self.publicClient = nil
        }
    }

    // Required function for the MSAuthenticationProvider interface
    func getAccessToken(for authProviderOptions: MSAuthenticationProviderOptions!, andCompletion completion: ((String?, Error?) -> Void)!) {
        getTokenSilently(completion: completion)
    }

    public func getTokenInteractively(parentView: UIViewController, completion: @escaping(_ accessToken: String?, Error?) -> Void) {
        let webParameters = MSALWebviewParameters(parentViewController: parentView)
        let interactiveParameters = MSALInteractiveTokenParameters(scopes: self.graphScopes,
                                                                   webviewParameters: webParameters)
        interactiveParameters.promptType = MSALPromptType.selectAccount

        // Call acquireToken to open a browser so the user can sign in
        publicClient?.acquireToken(with: interactiveParameters, completionBlock: {
            (result: MSALResult?, error: Error?) in
            guard let tokenResult = result, error == nil else {
                print("Error getting token interactively: \(String(describing: error))")
                completion(nil, error)
                return
            }

            print("Got token interactively: \(tokenResult.accessToken)")
            completion(tokenResult.accessToken, nil)
        })
    }

    public func getTokenSilently(completion: @escaping(_ accessToken: String?, Error?) -> Void) {
        // Check if there is an account in the cache
        var userAccount: MSALAccount?

        do {
            userAccount = try publicClient?.allAccounts().first
        } catch {
            print("Error getting account: \(error)")
        }

        if (userAccount != nil) {
            // Attempt to get token silently
            let silentParameters = MSALSilentTokenParameters(scopes: self.graphScopes, account: userAccount!)
            publicClient?.acquireTokenSilent(with: silentParameters, completionBlock: {
                (result: MSALResult?, error: Error?) in
                guard let tokenResult = result, error == nil else {
                    print("Error getting token silently: \(String(describing: error))")
                    completion(nil, error)
                    return
                }

                print("Got token silently: \(tokenResult.accessToken)")
                completion(tokenResult.accessToken, nil)
            })
        } else {
            print("No account in cache")
            completion(nil, NSError(domain: "AuthenticationManager",
                                    code: MSALError.interactionRequired.rawValue, userInfo: nil))
        }
    }

    public func signOut() -> Void {
        do {
            // Remove all accounts from the cache
            let accounts = try publicClient?.allAccounts()

            try accounts!.forEach({
                (account: MSALAccount) in
                try publicClient?.remove(account)
            })
            print("accounts: \(accounts?.count)")
        } catch {
            print("Sign out error: \(String(describing: error))")
        }
    }
}
// </AuthManagerSnippet>
