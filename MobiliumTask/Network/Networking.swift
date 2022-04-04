//
//  Networking.swift
//  MobiliumTask
//
//  Created by Fetih Tunay Yetişir on 30.03.2022.
//

import Foundation
import UIKit
import Alamofire


public class NetworkManager {


    private let session: URLSession


    init() {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil

        session = URLSession.init(configuration: config)
    }
    func fetchIMDBID(url:String, completionHandler: @escaping (IMDBID?) -> Void )->String{
        var id = String()
        AF.request(url).responseDecodable(of: IMDBID.self){ (model) in
            guard let data = model.value else {
                completionHandler(nil)
                return
            }

            id = data.imdbId
            completionHandler(data)

        }
        return id
    }


    func fetchFromAPI(page: Int, urlString:String, completionHandler: @escaping (MoviesResponseModel?) -> Void) {

        let str = "\(urlString)?api_key=\(APIKey.key)&page=\(page)"

        AF.request(str).responseDecodable(of: MoviesResponseModel.self) { (model) in
            guard let data = model.value else{
                completionHandler(nil)
                return
            }


            completionHandler(data)

        }
    }

    func fetchWithURLSession(urlString: String, completionHandler: @escaping (MoviesResponseModel?) -> Void){

        if let url = URL(string: urlString){
            print(url)

            let task = session.dataTask(with: url) { (data, response, error) in

                if let err = error {
                    print("An Error Occured \(err.localizedDescription)")
                    completionHandler(nil)
                    return
                }
                guard let mime = response?.mimeType, mime == "application/json" else {
                    print("Wrong MIME type!")
                    completionHandler(nil)
                    return
                }
                if let jsonData = data {
                    do {
                        let decoder = JSONDecoder()

                        let decodedNowPlayingModel = try decoder.decode(MoviesResponseModel.self, from: jsonData)
                        
                        completionHandler(decodedNowPlayingModel)
                    } catch {
                        print("JSON error: \(error)")
                    }
                }
            }
            task.resume()
        }


    }
}
