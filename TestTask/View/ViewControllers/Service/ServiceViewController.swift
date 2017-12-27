import UIKit

public class ServiceViewController: UIViewController,
                                    UITableViewDelegate,
                                    UITableViewDataSource,
                                    IServiceView {
    
    
    @IBOutlet weak var quotesTableView: UITableView!
    @IBOutlet weak var trobber: UIActivityIndicatorView!
    
    private var controller: IServiceController?
    var quotes: [Quote] = [Quote]()
    
    override
    public func viewDidLoad() {
        quotesTableView.delegate = self
        quotesTableView.dataSource = self
        
        quotesTableView.rowHeight = UITableViewAutomaticDimension
        quotesTableView.estimatedRowHeight = 300
        
        controller = ServiceController()
        controller?.attachView(newView: self)
        
        super.viewDidLoad()
    }
    
    override
    public func viewDidAppear(_ animated: Bool) {
        trobber.isHidden = false
        trobber.startAnimating()
        quotesTableView.isHidden = true
        
        self.quotes.removeAll()
        quotesTableView.reloadData()
        controller?.viewIsReady()
    }
    
    public func showQuotes(quotes: Array<Quote>) {
        self.quotes = quotes
        quotesTableView.reloadData()
        trobber.isHidden = true
        quotesTableView.isHidden = false
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemQuoteCell") as! ItemQuoteCell
        let quote = quotes[indexPath.row]
        
        cell.lblQuote.text = quote.getQuote()
        cell.lblDateTimeCreated.text = quote.getDateTime()
        cell.lblRating.text = NSLocalizedString("rating", comment: "") + ": \(quote.getRating())"
        
        return cell
    }

    

}
