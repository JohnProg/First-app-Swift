import Foundation


public class Quote {
    
    private var autor: String?
    private var textQuote: String?
    private var rating: String?
    private var dateTime: String?
    
    //setters
    public func setAutor(name: String) -> Void {
        autor = name
    }
    
    public func setQuote(quote: String) -> Void {
        textQuote = quote
    }
    
    public func setRating(newRating: String) -> Void {
        rating = newRating
    }
    
    public func setDateTime(newDateTime: String) -> Void {
        dateTime = newDateTime
    }
    //setters
    
    
    
    //getters
    public func getAutor() -> String {
        return autor!
    }
    
    public func getQuote() -> String {
        return textQuote!
    }
    
    public func getRating() -> String {
        return rating!
    }
    
    public func getDateTime() -> String {
        return dateTime!
    }
    //getters
    
    
}
