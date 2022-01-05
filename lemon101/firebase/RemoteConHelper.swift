//
//  RemoteConHelper.swift
//  lemon101
//
//  Created by Jim Hsu on 2022/1/3.
//

import Foundation
import FirebaseRemoteConfig
import Combine


extension RemoteConfig{
    public func fetchAndActivate() -> AnyPublisher<RemoteConfigFetchAndActivateStatus, Error>{
        Future<RemoteConfigFetchAndActivateStatus, Error>{[weak self] promise in
            self?.fetchAndActivate { result, error in
                if let error = error{
                    promise(.failure(error))
                }else{
                    promise(.success(result))
                }
            }
        }.eraseToAnyPublisher()
    }
}

final class RemoteConHelper:ObservableObject{
    
    enum State:Equatable{
        case idle
        case error
        case loading
        case loaded(Bool) //true means new data
        
        func desc() -> String{
            switch self{
            case .loaded(let fetched):
                return "fetched \(fetched)"
            default:
                return "not loaded"
            }
        }
    }
    
    static let shared = RemoteConHelper()
    fileprivate let remoteConfig = RemoteConfig.remoteConfig()
    
    let stateRelay = CurrentValueSubject<State, Never>(.idle)
    
    fileprivate var cancellables = Set<AnyCancellable>()
    init(){
        let settings = RemoteConfigSettings()
        settings.fetchTimeout = 10 //timeout 10s
        settings.minimumFetchInterval = 0 // 3600 * 4 or 12?
        remoteConfig.configSettings = settings
        remoteConfig.setDefaults(fromPlist: ConfigKey.pListFileName)
        fetachAndActivate()
    }
    fileprivate func fetachAndActivate(){
        stateRelay.send(.loading)
        remoteConfig.fetchAndActivate()
            .sink(receiveCompletion: { result in
                switch result{
                case .finished:
                    return
                case .failure(let error):
                    ffl(error.localizedDescription)
                    self.stateRelay.send(.error);return
                }
            }, receiveValue: { status in
                switch status{
                case .successFetchedFromRemote:
                    self.stateRelay.send(.loaded(true))
                case .successUsingPreFetchedData:
                    self.stateRelay.send(.loaded(false))
                default:
                    self.stateRelay.send(.error)
                }
            })
            .store(in: &cancellables)
    }

    func boolPublisher(for key: ConfigKey) -> AnyPublisher<Bool, Error>{
        remoteConfig.fetchAndActivate()
            .map{ (_) -> Bool in
                self.boolConfiguration(for: key)
            }
            .eraseToAnyPublisher()
    }
    func numberPublisher(for key:ConfigKey) -> AnyPublisher<NSNumber, Error>{
        remoteConfig.fetchAndActivate()
            .map{ (_) -> NSNumber in
                self.NumberConfiguration(for: key)
            }
            .eraseToAnyPublisher()
    }
    func stringPublisher(for key:ConfigKey) -> AnyPublisher<String?, Error>{
        remoteConfig.fetchAndActivate()
            .map{ (_) -> String? in
                self.stringConfiguration(for: key)
            }
            .eraseToAnyPublisher()
    }
    fileprivate func boolConfiguration(for key:ConfigKey) -> Bool{
        remoteConfig.configValue(forKey: key.rawValue).boolValue
    }
    fileprivate func NumberConfiguration(for key:ConfigKey) -> NSNumber{
        remoteConfig.configValue(forKey: key.rawValue).numberValue
    }
    fileprivate func stringConfiguration(for key:ConfigKey) -> String?{
        remoteConfig.configValue(forKey: key.rawValue).stringValue
    }
}
