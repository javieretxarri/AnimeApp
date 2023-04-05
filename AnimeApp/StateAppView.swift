//
//  StateAppView.swift
//  AnimeApp
//
//  Created by Javier Etxarri on 3/4/23.
//

import SwiftUI

struct StateAppView: View {
    @EnvironmentObject var vm: AnimesVM
    @Namespace var namespace
    @State var viewState: NavigationState = .splash

    var body: some View {
        Group {
            switch viewState {
            case .splash:
                splash
                    .onAppear {
                        Task {
                            try await Task.sleep(for: .seconds(1.5))

                            if vm.welcomeDone {
                                viewState = .home
                            } else {
                                viewState = .welcome
                            }
                        }
                    }
            case .welcome:
                Welcome(state: $viewState, namespace: namespace)
            case .home:
                Home()
            case .detail:
                EmptyView()
            }
        }
        .animation(.easeOut, value: viewState)
    }

    var splash: some View {
        VStack {
            Image("logotipo")
                .matchedGeometryEffect(id: "logotipo", in: namespace)
        }
    }
}

struct StateAppView_Previews: PreviewProvider {
    static var previews: some View {
        StateAppView()
    }
}
