import Foundation
import SwiftyJSON
import Alamofire

public class ServiceController:  NSObject,
                            IServiceController {

    private var view: IServiceView?
    
    func attachView(newView: IServiceView) {
        view = newView
    }
    
    public func viewIsReady() -> Void {
        var quotes = [Quote]()
        
        let quotesRepository = QuotesReposytory()
        quotesRepository.loadQuotes(comletionHandler: { resultQuotes in
            quotes = resultQuotes
            self.view?.showQuotes(quotes: quotes)
        })
    }
    
}
