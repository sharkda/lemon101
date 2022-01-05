//
//  BuyBox.swift
//  lemon101
//
//  Created by Jim Hsu on 2021/12/29.
//

import SwiftUI
import Combine

struct BuyBox: View {
    
    @Binding var stateExpressCheckoutLoaded: RemoteConHelper.State
    
    @State var showFeature:Bool = false
    
    @ObservedObject var viewModel = LemonObservable.shared
    
    var body: some View {
        VStack(alignment: .center, spacing: 8){
            Text("buybox")
            if case .loaded(let isExpressCheckoutEnabled) = stateExpressCheckoutLoaded,
               isExpressCheckoutEnabled{
                Text("True!")
//                Button("Express Checkout"){foo()}
//                .foregroundColor(.red)
//                .frame(height: 40)
            }
            Divider()
            if showFeature{
                Text("features!")
            }
        } //: vstack
//        .onChange(of: LemonViewModel.shared.state, perform: { state in
//            if case .loaded(let isExpressCheckoutEnabled) = stateExpressCheckoutLoaded{
//                self.showFeature = isExpressCheckoutEnabled
//            }
//        })
    }
}
   


//struct BuyBox_Previews: PreviewProvider {
//    static var previews: some View {
//        BuyBox()
//    }
//}
