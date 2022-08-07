//
//  MapView.swift
//  Swift-Userlocation
//
//  Created by Yusuf Balta on 4.08.2022.
//

import MapKit
import SwiftUI

struct MapView: View {
    @StateObject private var viewModel = MapViewModel()
    var body: some View {
        Map(
            coordinateRegion: $viewModel.region,
            showsUserLocation: true
        )
            .ignoresSafeArea()
            .accentColor(Color(.systemPink))
            .onAppear{
                viewModel.checkIfLocationServiceIsEnabled()
            }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
