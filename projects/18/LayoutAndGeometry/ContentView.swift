//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Tyler Steele on 11/21/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { proxy in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(Color(hue: getHue(proxy), saturation: 0.8, brightness: 0.9))
                            .opacity(getOpacity(proxy))
                            .rotation3DEffect(.degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            .scaleEffect(max(0.5, proxy.frame(in: .global).minY * 0.002))
                    }
                    .frame(height: 40)
                }
            }
        }
    }
    
    func getOpacity(_ proxy: GeometryProxy) -> Double {
        let yPosition = proxy.frame(in: .global).minY
        if yPosition < 200 {
            return 0.0035 * yPosition
        }
        return 1.0
    }
    
    func getHue(_ proxy: GeometryProxy) -> Double {
        let maxValue = 1.0
        let minValue = 0.0
        let yPosition = proxy.frame(in: .global).minY
        return min(maxValue, max(minValue, 100.0 / yPosition))
    }
}

#Preview {
    ContentView()
}
