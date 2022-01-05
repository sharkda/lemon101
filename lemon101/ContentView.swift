//
//  ContentView.swift
//  lemon101
//
//  Created by Jim Hsu on 2021/12/29.
//

import SwiftUI

struct ContentView: View {
    
    @State var viewModel:LemonObservable
    
    var body: some View {
        VStack{
            Text("ContentView")
                .padding()
            LemonBox()
        }
       
    }
    
    init(){
        viewModel = LemonObservable.shared
    }
}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
