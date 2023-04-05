//
//  Welcome.swift
//  AnimeApp
//
//  Created by Javier Etxarri on 3/4/23.
//

import SwiftUI

enum WelcomeStep: Int {
    case stepOne = 1
    case stepTwo = 2
}

struct Welcome: View {
    @EnvironmentObject var vm: AnimesVM
    @Binding var state: NavigationState
    let namespace: Namespace.ID

    @State var step: WelcomeStep = .stepOne

    func setHomeState() {
        vm.setWelcomeDone(true)
        state = .home
    }

    var body: some View {
        VStack {
            switch step {
            case .stepOne:
                WelcomeScreen(step: $step,
                              namespace: namespace,
                              finalStep: setHomeState,
                              image: Image("stepOne"),
                              text: "In this screen you can see all the content. You can sort or filter to display the data as you prefer")
            case .stepTwo:
                WelcomeScreen(step: $step,
                              namespace: namespace,
                              finalStep: setHomeState,
                              image: Image("stepTwo"),
                              text: "In this screen you can see all the watched content. If you want to mark one content as watched you only need to swipe from left to rigth in first screeen")
            }
        }
        .animation(.easeInOut(duration: 1), value: step)
    }
}

struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        Welcome(state: .constant(.welcome), namespace: Namespace().wrappedValue)
    }
}

struct WelcomeScreen: View {
    @Binding var step: WelcomeStep
    let namespace: Namespace.ID
    let finalStep: () -> ()
    let image: Image
    let text: String

    var body: some View {
        VStack {
            Image("logotipo")
                .matchedGeometryEffect(id: "logotipo", in: namespace)
            image
                .resizable()
                .scaledToFit()
                .frame(width: 230)
                .cornerRadius(10)
            Text(text)
                .multilineTextAlignment(.center)
                .padding()

            Button {
                if let welcomeStep = WelcomeStep(rawValue: step.rawValue + 1) {
                    step = welcomeStep
                } else {
                    finalStep()
                }
            } label: {
                Text("Next Step")
            }
            .buttonStyle(.bordered)
        }
    }
}
