import Foundation
import Alamofire
import SwiftyJSON

public class QuotesReposytory {
    
    private let host = "http://quotes.zennex.ru/"
    private let path = "api/v3/bash/quotes"
    private let query = ["sort" : "time"]
    
    public func loadQuotes(comletionHandler: @escaping (Array<Quote>) -> Void) {
        Alamofire.request(host + path, parameters: query).responseJSON { response in
            let json = JSON(response.data as Any)
            let arrayQuotes = json["quotes"].arrayValue
            var resultQuotes = [Quote]()
            
            for quote in arrayQuotes {
                let newQuote = Quote()
                
                newQuote.setAutor(name: quote["id"].stringValue)
                newQuote.setQuote(quote: quote["description"].stringValue)
                newQuote.setRating(newRating: quote["rating"].stringValue)
                newQuote.setDateTime(newDateTime: quote["time"].stringValue)
                
                resultQuotes.append(newQuote)
            }
            
            comletionHandler(resultQuotes)
        }
    }
}
