//
//  ContentViewModel.swift
//  Assignment
//
//  Created by Kunal on 10/01/25.
//

import Foundation


class ContentViewModel : ObservableObject {
    
    private let apiService = ApiService()
    @Published var navigateDetail: DeviceData? = nil
    @Published var data: [DeviceData] = []

    func fetchAPI() async {
        let item: [DeviceData] = await withCheckedContinuation { continuation in
            apiService.fetchDeviceDetails(completion: { item in
                continuation.resume(returning: item)
            })
        }
       
        DispatchQueue.main.async {
            self.data = item
        }
    }
    
    func navigateToDetail(navigateDetail: DeviceData) {
        self.navigateDetail = navigateDetail
    }
}
