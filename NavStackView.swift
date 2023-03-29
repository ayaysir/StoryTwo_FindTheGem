//
//  NavStackView.swift
//  Find Gem
//
//  Created by 윤범태 on 2023/03/28.
//

import SwiftUI


// 1st nav
struct ColorDetail: View {
    var color: Color
    @Binding var message: String
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Text("\(color.description)")
            .foregroundColor(color)
        Divider()
        if #available(iOS 16.0, *) {
            // NavigationStack or NavigationView 없어도 됨
            NavigationLink("Go to Jacob Link", value: color.description).navigationDestination(for: String.self) { lastName in
                JacobDetail(lastName: lastName.capitalized, message: $message)
            }
        } else {
            // Fallback on earlier versions
        }
        Divider()
        Button {
            dismiss()
        } label: {
            Label("Back", systemImage: "chevron.left")
        }
    }
}

// 2nd nav
struct JacobDetail: View {
    var lastName: String
    @Binding var message: String
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Text("Jacob \(lastName)")
        Text("파발: \(message)")
        Button("왜곡") {
            message = "Julius Fucik"
        }
    }
}

struct NavStackView: View {
    @State var message: String = ""
    
    var body: some View {
        Image("동대문")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: .infinity, maxHeight: 150)
        if #available(iOS 16.0, *) {
            NavigationStack {
                List {
                    // 밖에 있으면 버튼, List 안에 있으면 목록 형태로 자동 변형
                    NavigationLink("동대문", value: Color.mint)
                    NavigationLink("서대문", value: Color.pink)
                    NavigationLink("남대문", value: Color.cyan)
                    NavigationLink("북대문", value: Color.teal)
                    TextField("파발로 보낼 말을 입력", text: $message)
                }
                // List 아래 위치
                .navigationTitle("조선시대 성문")
                .navigationDestination(for: Color.self) { color in
                    ColorDetail(color: color, message: $message)
                }
            }
        } else {
            // Fallback on earlier versions
            Text("Need iOS 16")
        }
    }
}

struct NavStackView_Previews: PreviewProvider {
    static var previews: some View {
        NavStackView()
    }
}
