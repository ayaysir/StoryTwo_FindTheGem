import SwiftUI

func probability(_ probability: Double) -> Bool {
    return Double.random(in: 0...1) < probability
}

struct StarrySky: View {
    @State var probability: Double = 0.05
    
    var body: some View {
        ForEach(0..<3) { _ in
            VStack {
                ForEach(0..<8) { _ in
                    Text(ChanceUtil.probability(probability) ? "⭐️" : " ")
                }
            }
        }
    }
}

struct Atmosphere: View {
    var body: some View {
        VStack {
            ForEach(0..<10) {_ in
                Text(" ")
            }
        }
    }
}

struct Land: View {
    var body: some View {
        VStack {
            Text("🟫")
            Text(" ")
        }
    }
}

struct Tree: View {
    @State var probability: Double = 0.1
    var body: some View {
        VStack {
            Text(ChanceUtil.probability(probability) ? (ChanceUtil.probability(0.9) ? "🌲" : "🎄") : " ")
        }
    }
}

struct ContentView: View {
    @State var isScrolling = false
    
    func animateWithTimer(proxy: ScrollViewProxy, count: Int = 300, duration: Double = 15.0) {
        let timeInterval: Double = (duration / Double(count))
        var counter: Int = 0
        
        let timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { (timer) in
            withAnimation(.linear) {
                proxy.scrollTo("Y-\(counter)")
            }
            counter += 1
            if counter >= count {
                timer.invalidate()
            }
        }
        
        timer.fire()
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                ScrollViewReader { scrollViewProxy in
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(0..<300) { item in
                                VStack {
                                    StarrySky(probability: 0.03)
                                    Atmosphere()
                                    Tree()
                                    Land()
                                }.id("Y-\(item)")
                            }
                        }
                        .id("PurpleLine")
                    }
                    .frame(maxHeight: .infinity)
                    .onAppear {
                        // // 바로 이동 (애니메이션 X)
                        // scrollViewProxy.scrollTo("PurpleLine")
                        
                        // // 이동하는데 시간 설정 불가
                        // DispatchQueue.main.async {
                        //     withAnimation(.easeOut(duration: 30000)) {
                        //         scrollViewProxy.scrollTo("PurpleLine")
                        //     }
                        // }
                        
                        // DispatchQueue.main.async {
                        //     withAnimation(.easeOut(duration: 3)) {
                        //         scrollViewProxy.scrollTo("Y-30")
                        //     }
                        // }
                        animateWithTimer(proxy: scrollViewProxy)
                    }
                }
            }.onAppear {
                isScrolling = true
            }
            VStack {
                Spacer()
                Text("🚶‍♂️")
                    .flipped(.horizontal)
                Spacer().frame(height: 46)
            }
        }
    }
}
