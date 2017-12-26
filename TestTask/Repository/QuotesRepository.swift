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
                let description = self.decodeString(encodedString: quote["description"].stringValue)
                
                newQuote.setAutor(name: quote["id"].stringValue)
                newQuote.setQuote(quote: (description?.string)!)
                newQuote.setRating(newRating: quote["rating"].stringValue)
                newQuote.setDateTime(newDateTime: quote["time"].stringValue)
                
                resultQuotes.append(newQuote)
            }
            
            comletionHandler(resultQuotes)
        }
    }
    
    private func decodeString(encodedString: String) -> NSAttributedString?
    {
        let encodedData = encodedString.data(using: String.Encoding.utf8)!
        do {
            return try NSAttributedString(data: encodedData, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
    }
}
