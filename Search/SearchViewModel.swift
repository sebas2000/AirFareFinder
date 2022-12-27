//
//  File.swift
//  AirFareFinder
//
//  Created by Sebastian Chab Vives on 04/12/2022.
//

import Foundation


enum JSONAPIError: Error {
    case networkError(message: String)
    case requestError(message: String)
    case authenticationError(message: String)
}

class SearchViewModel: ObservableObject {
    private let version = 9

    //let langModel = LanguageModel.instance
    //@Published var contentData: [Content] = []
    @Published var response: SearchResponse?
    
        //= load(categoriesFileName())
    
    //MARK: Public Methods
    public init() {
//        let nc = NotificationCenter.default
//        loadData()
//        nc.addObserver(self, selector: #selector(languageChanged), name: Notification.Name(LanguageModel.LANGUAGE_CHANGED), object: nil)
       
   }
//
    
    public func search(query: SearchQuery)  async -> Void {
      //  var anAPIerror:JSONAPIError?
     //   var offerings : SearchResponse?

        var request = URLRequest(url: getJSONAPIURL(query: query))
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("xF-ztT6FfM9t1vUnPjbnqYI4laFt78pZ", forHTTPHeaderField: "apikey")

        //request.httpBody = getBody()
        do{
            let (data, meta) = try await URLSession.shared.data(for:  request)
           let str = String(decoding: data, as: UTF8.self)
            print("********** data")
            print(str)
            print("********** ")
//            print(meta)

            let decoder =  JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601

            self.response = try decoder.decode(SearchResponse.self, from: data)

            // = try JSONDecoder().decode(SearchResponse.self, from: data)

        } catch {
            print("********** \(error)")
            print("Invalid response \(error)")
        }
        
     /*
        { (data, metaData, error) in
            if let error = error {
                anAPIerror = JSONAPIError.networkError(message: error.localizedDescription)
            }
            //print(response.)
            if let data = data {
//               let str = String(decoding: data, as: UTF8.self)
//                print(str)
                do {
                    // make sure this JSON is in the format we expect
//                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                        offerings.jsonDict = json
//                    }
                    self.response = try JSONDecoder().decode(SearchResponse.self, from: data)
                } catch let error as NSError {
                    anAPIerror = JSONAPIError.requestError( message: error.localizedDescription )

                    print("Failed to load: \(error)")
                }
            } else {
                anAPIerror = JSONAPIError.networkError(message: "nil data")
            }
        }
        */
           print("1")
        
        
    }

    //MARK: Helper Methods
    private func getJSONAPIURL(query: SearchQuery) -> URL   {
        let format = DateFormatter()
        format.dateFormat="dd/MM/yyyy"
        let dateFrom = format.string(from: query.dateFrom)
        let dateTo = format.string(from: query.dateTo)

        var urlStr = "https://api.tequila.kiwi.com/v2/search?fly_from=\(query.from)&fly_to=\(query.to)&dateFrom=\(dateFrom)&dateTo=\(dateTo)"

        let url = URL(string: urlStr)!
        return url
    }
 
    public static func loadAirports() -> [Airport]   {
        var airports = [Airport]()
        do {
            let fileURL = Bundle.main.url(forResource:"RAPT", withExtension: "json")!
            
            let data = try Data(contentsOf:  fileURL)
            let decoder =  JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            airports = try decoder.decode([Airport].self, from: data)
        } catch {
            fatalError("Couldn't load:\n\(error)")
        }
        return airports
    }
 
}


