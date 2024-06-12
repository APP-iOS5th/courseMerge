//
//  LocationManager.swift
//  CourseMerge
//
//  Created by 황규상 on 6/10/24.
//

import SwiftUI
import MapKit
import CoreLocation

/// 사용자의 위치를 관리하는 Class (위치 업데이트 및 권한 변경 이벤트를 처리)
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation? // 위치 정보를 업데이트할 때 UI에 알림
    @Published var authorizationStatus: CLAuthorizationStatus // 위치 접근 권한 상태를 저장
    
    override init() {
        self.authorizationStatus = locationManager.authorizationStatus
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 위치 정확도를 가장 높게 설정
        locationManager.requestWhenInUseAuthorization() // 사용 중 위치 접근 권한을 요청
        locationManager.startUpdatingLocation() // 위치 업데이트를 시작
    }

    /// 위치를 요청하는 Method
    func requestLocation() {
        locationManager.requestLocation()
    }
    
    // MARK: Delegate Method
    
    /// 위치가 업데이트될 때 호출되는 Delegate Method (가장 최근 위치를 저장)
    /// - Parameters:
    ///   - manager: CLLocationManager 인스턴스
    ///   - locations: 업데이트된 위치 배열
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first
    }
    
    /// 위치 정보를 가져오지 못했을 때 호출되는 Delegate Method (에러메세지 출력)
    /// - Parameters:
    ///   - manager: CLLocationManager 인스턴스
    ///   - error: 오류 객체
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error.localizedDescription)")
    }
    
    /// 위치 접근 권한이 변경될 때 호출되는 Delegate Method
    /// - Parameters:
    ///   - manager: CLLocationManager 인스턴스
    ///   - status: 새로운 권한 상태
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationStatus = status
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation() // 권한이 허용, 위치 업데이트 시작.
        case .denied, .restricted:
            print("Location access denied or restricted") // 권한이 거부 || 제한, 메시지를 출력.
        default:
            break
        }
    }
}
