//
//  ContentView.swift
//  Assignment
//
//  Created by Kunal on 03/01/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel()
    @State private var path: [DeviceData] = [] // Navigation path
    @State var searchtext = ""

    var body: some View {
        NavigationStack(path: $path) {
            RoundedRectangle(cornerRadius: 20)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                .frame(height: 40)
                .overlay(content: {
                    TextField("Search Device", text: $searchtext)
                        .padding(.horizontal, 20)
                })
            
            Group {
                if searchtext.isEmpty{
                    if viewModel.data.isEmpty {
                        ProgressView("Loading...")
                    } else {
                        DevicesList(devices: viewModel.data) { selectedComputer in
                            viewModel.navigateToDetail(navigateDetail: selectedComputer)
                        }
                    }
                }
            }
            .onChange(of: viewModel.navigateDetail, {
                let navigate = viewModel.navigateDetail
                path.append(navigate!)
            })
            .navigationTitle("Devices")
            .navigationDestination(for: DeviceData.self) { computer in
                DetailView(device: computer)
            }
            .task({
                await viewModel.fetchAPI()
            })
        }
    }
}
