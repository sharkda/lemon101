//
//  LemonViewModel.swift
//  lemon101
//
//  Created by Jim Hsu on 2021/12/31.
//
import Combine
import Foundation
import SceneKit
import SwiftUI

/** **todo: adopt below.  */
enum ConfigKey:String{
    
    case pushPerDay = "push_per_day"  //1,2
    case startHourOfDay = "start_hour_of_day" //8
    //case startMinuteOfDay = "start_minute_of_day" //0, no value
    case pushIntervalMinutes = "push_inerval_minutes" // 9h : 540m
    
    case someBool = "some_bool"
    case someDouble = "some_double"
    static let pListFileName = "defaultRemoteConfig"
}

typealias remConState = RemoteConHelper.State

final class LemonObservable: ObservableObject, Identifiable{
    
    static let shared = LemonObservable()
    
    @ObservedObject var remoteCon:RemoteConHelper
   
    let remoteConStateRelay = CurrentValueSubject<remConState, Never>(.idle)
    @Published var someBool = false
    @Published var pushPerDay:Int = 0
    @Published var startHourOfDay:Int = 0
    //@Published var startMinuteOfDay:Int = 0
    @Published var pushInternvalMinutes:Int = 0
    //@Published var someDouble: Double = 0.0
    let someDoubleRelay = CurrentValueSubject<Double, Never>(0.0)
    fileprivate var cancellabls = Set<AnyCancellable>()
    
    fileprivate init(){
        remoteCon = RemoteConHelper.shared
        RemoteConHelper.shared.stateRelay.sink(receiveValue: {state in
            ffl("state: \(state)")
            self.remoteConStateRelay.send(state)
            assert(state != .error)
            self.loadRemoteConValue()
        })
        .store(in: &cancellabls)
    }
    /** this will iterate throught all remote con value 1b1  */
    /** the fatalError here is not necessary, I've have to c-out it for twofrogs to run*/
    fileprivate func loadRemoteConValue(){
        remoteCon.boolPublisher(for: .someBool)
            .sink(receiveCompletion: { result in
                if case .failure(let error) = result{
                    ffl(error.localizedDescription,.error);fatalError()
                }
            },
            receiveValue: { v0 in
                self.someBool = v0
            })
            .store(in: &cancellabls)
        
        remoteCon.numberPublisher(for: .pushPerDay)
            .sink(receiveCompletion: { result in
                if case .failure(let error) = result{
                    ffl(error.localizedDescription,.error);fatalError()
                }
            }, receiveValue: { v0 in
                self.pushPerDay = v0 as? Int ?? 0
            })
            .store(in: &cancellabls)
        
        remoteCon.numberPublisher(for: .pushIntervalMinutes)
            .sink(receiveCompletion: { result in
                if case .failure(let error) = result{
                    ffl(error.localizedDescription,.error);fatalError()
                }
            }, receiveValue: { v0 in
                self.pushInternvalMinutes = v0 as? Int ?? 0
            })
            .store(in: &cancellabls)
        
        remoteCon.numberPublisher(for: .startHourOfDay)
            .sink(receiveCompletion: { result in
                if case .failure(let error) = result{
                    ffl(error.localizedDescription,.error);fatalError()
                }
            }, receiveValue: { v0 in
                self.startHourOfDay = v0 as? Int ?? 0
            })
            .store(in: &cancellabls)

        
        remoteCon.numberPublisher(for: .someDouble)
            .sink(receiveCompletion: { result in
                if case .failure(let error) = result{
                    ffl(error.localizedDescription,.error);fatalError()
                }
            }, receiveValue: { v0 in
                self.someDoubleRelay.send((v0 as? Double ?? 0.0))
            })
            .store(in: &cancellabls)
    }
}
