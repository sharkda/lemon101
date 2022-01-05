//
//  FeatureFlagHelper.swift
//  lemon101
//
//  Created by Jim Hsu on 2021/12/29.
//

import Foundation
import FirebaseRemoteConfig
import Combine



protocol FeatureFlagHelperMethods{
    var isExpressedCheckoutEnabled: AnyPublisher<Bool, Error>{ get }
}

private enum FeatureFlagKeys:String{
    case expressCheckoutEnabled = "express_checkout_enabled"
}

class FeatureFlagHelper: FeatureFlagHelperMethods{
    var isExpressedCheckoutEnabled: AnyPublisher<Bool, Error>{
        return booleanPublisher(for: .expressCheckoutEnabled)
    }
    
    static let shared:FeatureFlagHelperMethods = FeatureFlagHelper()
    private let remoteConfig = RemoteConfig.remoteConfig()
    init(){
        ffl(">")
        let settings = RemoteConfigSettings()
        settings.fetchTimeout = 10.0 //timeout 10s
        settings.minimumFetchInterval = 0 // 3600 * 4 or 12?
        remoteConfig.configSettings = settings
        remoteConfig.setDefaults(fromPlist: "DefaultRemoteConfig")
    }
    private func booleanPublisher(for key:FeatureFlagKeys) -> AnyPublisher<Bool,Error>{
        remoteConfig.fetchAndActivate()
            .map{ (_) -> Bool in
                return self.boolConfiguration(for: key)
            }
            .eraseToAnyPublisher()
    }
    fileprivate func boolConfiguration(for key: FeatureFlagKeys) -> Bool{
        return remoteConfig.configValue(forKey: key.rawValue).boolValue
    }
    
}
