//
//  ContentView.swift
//  MacosTest
//
//  Created by Winlentia on 15.08.2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var colorSource = DataSource(defaultColor: .black)
    @State var isHiddenTextActive: Bool = false
    let defaultColor = Color.black
    
    var body: some View {
        
        ZStack{
            HStack{
                ZStack{
                    Color(NSColor(colorSource.leftBackground))
                    VStack{
                        Spacer()
                        Button(!isHiddenTextActive ? "Press f for change color" : "") {
                            if colorSource.leftBackground == defaultColor {
                                colorSource.leftBackground = colorSource.leftColor
                            } else {
                                colorSource.leftBackground = defaultColor
                            }
                        }.keyboardShortcut("f", modifiers: [])
                        Spacer()
                        ColorPicker("Set color", selection: $colorSource.leftColor).isHidden(isHiddenTextActive)
                    }
                }
                ZStack{
                    Color(NSColor(colorSource.rightBackground))
                    VStack{
                        Spacer()
                        Button(!isHiddenTextActive ? "Press j for change color" : "") {
                            if colorSource.rightBackground == defaultColor {
                                colorSource.rightBackground = colorSource.rightColor
                            } else {
                                colorSource.rightBackground = defaultColor
                            }
                        }.keyboardShortcut("j", modifiers: [])
                        Spacer()
                        ColorPicker("Set color", selection: $colorSource.rightColor).isHidden(isHiddenTextActive)
                    }
                }
                
            }
            ZStack {
                Button("") {
                    isHiddenTextActive = !isHiddenTextActive
                }.frame(width: 0, height: 0, alignment: .center).keyboardShortcut("h", modifiers: [])
                Text(!isHiddenTextActive ? "Press h \n for hidden" : "").multilineTextAlignment(.center)
            }
//            Button("Press h \nfor hidden").multilineTextAlignment(.center).keyboardShortcut("h", modifiers: [])
        }.onAppear(perform: {
            onAppearMethod()
        })
        
    }
    
}

func onAppearMethod() {
    print("onAppear method runned")
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class DataSource: ObservableObject {
    init(defaultColor: Color) {
        leftBackground = defaultColor
        rightBackground = defaultColor
    }
    @Published var leftColor = Color.red
    @Published var rightColor = Color.blue
    @Published var leftBackground: Color
    @Published var rightBackground: Color
}

extension View {
    
    /// Hide or show the view based on a boolean value.
    ///
    /// Example for visibility:
    ///
    ///     Text("Label")
    ///         .isHidden(true)
    ///
    /// Example for complete removal:
    ///
    ///     Text("Label")
    ///         .isHidden(true, remove: true)
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}
