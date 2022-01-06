//
//  LemonBox.swift
//  lemon101
//
//  Created by Jim Hsu on 2022/1/4.
//

import SwiftUI
import Combine

struct LemonBox: View {
    
    @EnvironmentObject var lemonOb:LemonObservable
    
    var body: some View {
        VStack(alignment: .center, spacing: 8){
            Text("Lemonbox")
                .font(.title)
            Text("state = \(lemonOb.remoteConStateRelay.value.desc())")
            Text("\(ConfigKey.pushPerDay.rawValue) = \(lemonOb.pushPerDay)")
            Text("\(ConfigKey.pushIntervalMinutes.rawValue) = \(lemonOb.pushInternvalMinutes)")
            Text("\(ConfigKey.startHourOfDay.rawValue) = \(lemonOb.startHourOfDay)")
        } //: vstack
        .font(.headline)
        .foregroundColor(.gray)
    }
}
//
//struct LemonBox_Previews: PreviewProvider {
//    static var previews: some View {
//        LemonBox()
//    }
//}
