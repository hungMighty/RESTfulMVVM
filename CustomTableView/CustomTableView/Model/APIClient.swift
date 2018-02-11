//
//  APIClient.swift
//  CustomTableView
//
//  Created by 2B on 11/14/17.
//  Copyright © 2017 Automata. All rights reserved.
//

import Alamofire
import SwiftyJSON
import CoreTelephony

enum APIResult<T> {
    case Success(T)
    case Failure(String)
}

class APIClient {
    
    static let shared = APIClient()
    private init() {}
    
    fileprivate func errorHandling(errParam: Error) {
        guard let err = errParam as? AFError else {
            if let urlErr = errParam as? URLError {
                print("URLError occurred: \(urlErr)")
            } else {
                print("Unknown error: \(errParam)")
            }
            return
        }
        
        switch err {
        case .invalidURL(let url):
            print("Invalid URL: \(url) - \(err.localizedDescription)")
        case .parameterEncodingFailed(let reason):
            print("Parameter encoding failed: \(err.localizedDescription)")
            print("Failure reason: \(reason)")
        case .multipartEncodingFailed(let reason):
            print("Multipart encoding failed: \(err.localizedDescription)")
            print("Failure Reason: \(reason)")
        case .responseValidationFailed(let reason):
            print("Response validation failed: \(err.localizedDescription)")
            print("Failure Reason: \(reason)")
            switch reason {
            case .dataFileNil, .dataFileReadFailed:
                print("Downloaded file could not be read")
            case .missingContentType(let acceptableContentTypes):
                print("Content Type Missing: \(acceptableContentTypes)")
            case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                print("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
            case .unacceptableStatusCode(let code):
                print("Response status code was unacceptable: \(code)")
            }
            
        case .responseSerializationFailed(let reason):
            print("Response serialization failed: \(err.localizedDescription)")
            print("Failure Reason: \(reason)")
        }
    }
    
    // MARK: - If Wifi then we can upload images
    
    func isReachableViaCellular() -> Bool {
        let networkInfo = CTTelephonyNetworkInfo()
        let networkString = networkInfo.currentRadioAccessTechnology
        // Access Tech wiki:
        // https://stackoverflow.com/questions/25405566/mapping-ios-7-constants-to-2g-3g-4g-lte-etc
        
        
        // ReachableViaWWAN
        if
            /* LTE (4G) */
            networkString == CTRadioAccessTechnologyLTE ||
                
                /* 3G */
                networkString == CTRadioAccessTechnologyWCDMA ||
                networkString == CTRadioAccessTechnologyHSDPA ||
                networkString == CTRadioAccessTechnologyHSUPA ||
                networkString == CTRadioAccessTechnologyCDMAEVDORev0 ||
                networkString == CTRadioAccessTechnologyCDMAEVDORevA ||
                networkString == CTRadioAccessTechnologyCDMAEVDORevB ||
                networkString == CTRadioAccessTechnologyeHRPD ||
                
                /* EDGE (2G) */
                networkString == CTRadioAccessTechnologyGPRS ||
                networkString == CTRadioAccessTechnologyEdge ||
                networkString == CTRadioAccessTechnologyCDMA1x {
            return true
        }
        return false
    }
    
    func checkIsReachableViaWifi() -> Bool {
        guard let connectionState = NetworkReachabilityManager(host: "https://simplifiedcoding.net/demos/marvel/") else {
            print("Fail to create connection manager")
            return false
        }
        
        // The other is WWAN which is for 3g and 4g
        print("Is reachable via Wifi? \(connectionState.isReachableOnEthernetOrWiFi)")
        return connectionState.isReachableOnEthernetOrWiFi
    }
    
    func fetchHeroesList(completion: @escaping (APIResult<[Hero]>) -> Void) {
        guard let url = URL(string: "https://simplifiedcoding.net/demos/marvel/") else {
            print("Error unwrapping URL")
            return
        }
        
        Alamofire.request(url).responseJSON { (response) in
            switch response.result {
            case .success(_):
                let decoder = JSONDecoder()
                do {
                    if let myData = response.data {
                        let heroesArr = try decoder.decode([Hero].self, from: myData)
                        completion(.Success(heroesArr))
                    }
                } catch let err {
                    print("error trying to convert data to JSON")
                    print(err.localizedDescription)
                    completion(.Failure("Server returned wrong data format"))
                }
                
            case .failure(let err):
                self.errorHandling(errParam: err)
                completion(.Failure(err.localizedDescription))
            }
        }
    }

}
