//
//  MapViewModel.swift
//  Swift-Userlocation
//
//  Created by Yusuf Balta on 4.08.2022.
//


import MapKit

struct MapConfig{
    var initLocation : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 37.331516, longitude: -121.891054)
    var defaultCoordinateSpan : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
}

final class MapViewModel :NSObject ,ObservableObject, CLLocationManagerDelegate{
    var locationManager: CLLocationManager?
    
    @Published var region : MKCoordinateRegion = MKCoordinateRegion(center:  MapConfig().initLocation , span: MapConfig().defaultCoordinateSpan)
    
    
    func checkIfLocationServiceIsEnabled(){
        if(CLLocationManager.locationServicesEnabled()){
            locationManager = CLLocationManager()
            locationManager?.delegate=self
        }
        else{
            print("konum kapalı")
        }
    }
    func checkLocationPermisson(){
        guard let locationManager = locationManager else {
            return
        }
        switch locationManager.authorizationStatus{
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                print("restricted")
            case .denied:
                print("denided")
                
            case .authorizedAlways,.authorizedWhenInUse:
                region = MKCoordinateRegion(center:locationManager.location!.coordinate,span: MapConfig().defaultCoordinateSpan)
            default:
                break
        }
        
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationPermisson()
    }
    
}

