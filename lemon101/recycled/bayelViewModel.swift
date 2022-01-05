//
//  ViewModel.swift
//  lemon101
//
//  Created by Jim Hsu on 2021/12/29.
//

import Foundation
import Combine

final class bayelViewModel: ObservableObject, Identifiable{
    static let shared = bayelViewModel()
    enum State:Equatable{
        case idle
        case loading
        case loaded(Bool)
    }
    @Published var state = State.idle
    
    fileprivate var cancellableSet = Set<AnyCancellable>()
    
    fileprivate init(){
        load()
    }
    
    func load(){
        ffl(">")
        self.state = .loading
        FeatureFlagHelper.shared.isExpressedCheckoutEnabled
            .catch{ _ in Just(false)}
            .print("vm.load>")
            .receive(on:RunLoop.main)
            .map{ result -> State in
                ffl("loaded result \(result)")
                return State.loaded(result)
            }
            .assign(to: \.state, on: self)
            .store(in: &cancellableSet)
    }
}
