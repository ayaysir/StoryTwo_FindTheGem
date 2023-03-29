import SwiftUI

func starTextGenerator(blockNum: Int = 10, starProbability probability: Double) -> String {
    return (1...blockNum).map { _ in
        ChanceUtil.probability(probability) ? "⭐️" : "＿"
    }.joined(separator: "")
}

func treeTextGenerator(blockNum: Int = 10, treeProbability probability: Double) -> String {
    return (1...blockNum).map { _ in
        ChanceUtil.probability(probability) ? (ChanceUtil.probability(0.9) ? "🌲" : "🎄") : " "
    }.joined(separator: "")
}

let BLOCK_NUM = 300

struct StarrySky: View {
    @State var probability: Double = 0.05
    
    var body: some View {
        ForEach(0..<3) { _ in
            VStack(alignment: .leading) {
                ForEach(0..<10) { _ in
                    Text(starTextGenerator(blockNum: BLOCK_NUM, starProbability: probability))
                }
            }
        }
    }
}

struct Atmosphere: View {
    var body: some View {
        VStack {
            ForEach(0..<10) {_ in
                Text(String(repeating: " ", count: BLOCK_NUM))
            }
        }
    }
}

struct Land: View {
    var body: some View {
        VStack {
            Text(String(repeating: "🟫", count: BLOCK_NUM))
            Text(String(repeating: " ", count: BLOCK_NUM))
        }
    }
}

struct Tree: View {
    @State var probability: Double = 0.1
    var body: some View {
        VStack {
            Text(treeTextGenerator(treeProbability: 0.1))
        }
    }
}

struct MoveAndJumpView: View {
    @State var isScrolling = false
    @State var isJumping = false
    
    let JUMP_UP_DUR: CGFloat = 0.7
    
    /*
     애니메이션 관련
     https://stackoverflow.com/questions/57258846/how-to-make-a-swiftui-list-scroll-automatically
     
     animateWithTimer 출처
     https://stackoverflow.com/questions/65152436/swiftui-how-to-use-withanimation-in-a-scrollview
     */
    func animateWithTimer(proxy: ScrollViewProxy, count: Int = 500, duration: Double = 15.0) {
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
            VStack(alignment: .leading) {
                ScrollViewReader { scrollViewProxy in
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(0..<1) { item in
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
                        DispatchQueue.main.async {
                            withAnimation(.easeOut(duration: 30000)) {
                                scrollViewProxy.scrollTo("PurpleLine")
                            }
                        }
                        
                        // DispatchQueue.main.async {
                        //     withAnimation(.easeOut(duration: 3)) {
                        //         scrollViewProxy.scrollTo("Y-30")
                        //     }
                        // }
                        // animateWithTimer(proxy: scrollViewProxy, count: 500, duration: 5)
                    }
                }
            }.onAppear {
                isScrolling = true
            }
            VStack {
                Spacer()
                Text("🚶‍♂️")
                    .flipped(.horizontal)
                    .offset(x: 0, y: isJumping ? -50 : 0)
                    .animation(.linear(duration: JUMP_UP_DUR), value: isJumping)
                    .animation(.linear(duration: 0.3), value: !isJumping)
                Spacer().frame(height: 46)
            }
        }.onTapGesture {
            print("tap")
            isJumping = true
            Timer.scheduledTimer(withTimeInterval: JUMP_UP_DUR, repeats: false) { _ in
                self.isJumping = false
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        // MoveAndJumpView()
        NavStackView()
    }
}
