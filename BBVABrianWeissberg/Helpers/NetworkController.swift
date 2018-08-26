//
//  NetworkController.swift
//  BBVABrianWeissberg
//
//  Created by Brian Weissberg on 8/25/18.
//  Copyright © 2018 Brian Weissberg. All rights reserved.
//

import Foundation

class NetworkController {
    
    //
    // MARK: - Shared
    //
    
    static let shared = NetworkController()
    
    //
    // MARK: - Methods
    //
    
    func fetchStates(completion: @escaping (_ state: [State]) -> Void) {
        
        guard let url = URL(string: "http://services.groupkt.com/state/get/USA/all") else {
            print("There was an error with the URL. File: \(#file). Function: \(#function)")
            completion([])
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print("There was an error while fetching data: \(error.localizedDescription). File: \(#file). Function: \(#function)")
                completion([])
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("There was an invalid HTTP response: File: \(#file). Function: \(#function)")
                completion([])
                return
            }
            
            guard let data = data else {
                print("No data was returned. \(#file). Function: \(#function)")
                completion([])
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let values = try decoder.decode(States.self, from: data)
                completion(values.states)
            } catch {
                print("There was an error decoding states: File: \(#file). Function: \(#function). Error: \(error.localizedDescription)")
                completion([])
            }
        }
        dataTask.resume()
    }
}
