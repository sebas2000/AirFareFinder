import Foundation


//MARK: helper Types

enum APIError: Error {
    case networkError(message: String)
    case requestError(message: String)
    case authenticationError(message: String)
}

/*struct TokenContainer:Codable {
    public var access_token:String
}

public struct Response:Codable {
    public var CatalogOfferingsResponse : CatalogOfferingsResponse
}


public struct CatalogOfferingsResponse:Codable {
    public var transactionId : String
    public var CatalogOfferings : CatalogOfferings
}

public struct Identifier:Codable {
    public var value : String
}

public struct CatalogOfferings:Codable {
    public var Identifier : Identifier
    public var CatalogOffering : [CatalogOffering]
    //public var jsonDict : [String: Any]?
}

public struct Price:Codable {
    public var Base: Float
    public var TotalTaxes: Float
    public var TotalFees: Float
    public var TotalPrice: Float
}

public struct CatalogOffering:Codable {
    public var id : String
    public var Price : Price
}

*/
//MARK: Main Class

public class KiwiAPIAdapter {
    //private let version = 9
    //MARK: Helper Methods
    private func getJSONAPIURL() -> URL   {
        var urlStr = "https://api.tequila.kiwi.com/v2/search?fly_from=LGA&fly_to=MIA&dateFrom=01/04/2023&dateTo=02/04/2023"
        let url = URL(string: urlStr)!
        return url
    }
    
    //MARK: Public Methods

    public init() {}


    
    public func search(_ token: String) throws -> SearchResponse {
        var anAPIerror:APIError?
        var offerings : SearchResponse?

        var request = URLRequest(url: getJSONAPIURL())
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("xF-ztT6FfM9t1vUnPjbnqYI4laFt78pZ", forHTTPHeaderField: "apikey")
//        request.addValue("\(version)", forHTTPHeaderField: "Accept-Version")
//        request.addValue("\(version)", forHTTPHeaderField: "Content-Version")
//        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

     
        let semaphore: DispatchSemaphore = DispatchSemaphore(value: 0)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                anAPIerror = APIError.networkError(message: error.localizedDescription)
            }
            //print(response.)
            print("__________")
            if let data = data {
               let str = String(decoding: data, as: UTF8.self)
                print(str)
            print("__________")

                
                do {
                    // make sure this JSON is in the format we expect
//                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                        offerings.jsonDict = json
//                    }
                    let decoder =  JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    offerings = try decoder.decode(SearchResponse.self, from: data)

                   
                        
                } catch let error as NSError {
                    anAPIerror = APIError.requestError( message: error.localizedDescription )

                    print("Failed to load: \(error)")
                }
                
                
            } else {
                anAPIerror = APIError.networkError(message: "nil data")
            }
            print("2")
            semaphore.signal()
        }
        
        task.resume()
           print("1")
           semaphore.wait()
        
        if let anAPIerror = anAPIerror {
            throw anAPIerror

        }
        
        
        return offerings!
    }

    
    
//    func getRequestTaks(request: URLRequest) -> Task {
//        var anAPIerror:JSONAPIError?
//
//        return task
//    }
}
