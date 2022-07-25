//
//  AuthorizationServiceResponse.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 16.07.2022.
//

struct AuthorizationServiceResponse: Decodable {
    /// The device verification code is 40 characters and used to verify the device
    var deviceCode: String
    /// The user verification code is displayed on the device so the user can enter the code in a browser. This code is 8 characters with a hyphen in the middle.
    var userCode: String
    /// The verification URL where users need to enter the user_code: https://github.com/login/device.
    var verificationUri: String
    /// The number of seconds before the device_code and user_code expire. The default is 900 seconds or 15 minutes.
    var expiresIn: String
    /// The minimum number of seconds that must pass before you can make a new access token request (POST https://github.com/login/oauth/access_token) to complete the device authorization. For example, if the interval is 5, then you cannot make a new request until 5 seconds pass. If you make more than one request over 5 seconds, then you will hit the rate limit and receive a slow_down error.
    var interval: String
}
