//
//  LocationViewController.swift
//  SeSAC3Week6
//
//  Created by hoon on 2023/08/22.
//

import UIKit
import CoreLocation //1. 위치 임포트

class LocationViewController: UIViewController {
    
    
    //2. 위치 매니저 생성: 위치에 대한 대부분을 담당
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        
        //3. 위치 프로토콜 연결
        locationManager.delegate = self
        
        
        //info.plist << 얼럿
        //locationManager.requestWhenInUseAuthorization() //info에서 wheninuseDescription에 문구를 기입했기에 같은 메서드 선택해야된다.
        checkDeviceLocationAuthorization()
    }
    
    func checkDeviceLocationAuthorization() {
        
        
        //iOS 위치 서비스 활성화 체크
        
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                
                //현재 사용자의 위치 권한 상태를 가지고 옴
                let authorization: CLAuthorizationStatus
                
                if #available(iOS 14.0, *) {
                    authorization = self.locationManager.authorizationStatus
                } else {
                    authorization = CLLocationManager.authorizationStatus()
                }
                
                print(authorization)
                self.checkCurrentLocationAuthorization(status: authorization)
                
            } else {
                //Alert으로 대응
                print("위치 서비스가 꺼져 있어서 위치 권한 요청을 못합니다.")
            }
        }
    }
    
    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        print("check", status)
        switch status {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization() //alert을 띄워줌
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
        case .authorizedAlways:
            print("authorizedAlways")
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
            //didUpdatelocation 메서드 실행
            locationManager.startUpdatingLocation()
        case .authorized:
            print("authorized")
        }
    }
   

}

//4. 프로토콜 선언
extension LocationViewController: CLLocationManagerDelegate {

    //(didUpdate)
    //5. 사용자의 위치를 성공적으로 가지고 온 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("====",locations)
    }


    //(didFailWith))
    //6.사용자의 위치를 가지고 오지 못한 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }

    //(didchangeAuthorization)
    //사용자의 권한 상태가 바귈 때를 알려줌
    //거부했다가 설정에서 변경을 했거나, 혹은 noDeermined상태에서 허용을 했거나, 허용해서 위치를 가지고 오는 도중에, 설정에서 거부를 하고 앱으로 다시 돌아올 때 등
    //iOS14이상
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkDeviceLocationAuthorization()
    }

    //(didchangeAuthorization)
    //iOS14미만
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    
    }
}
