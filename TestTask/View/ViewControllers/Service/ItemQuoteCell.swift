import UIKit

public class ItemQuoteCell: UITableViewCell {

    
    @IBOutlet weak
    public var cellView: UIView!    
    
    @IBOutlet weak
    var lblQuote: UILabel!
    
    @IBOutlet weak
    public var lblRating: UILabel!
    
    @IBOutlet weak
    public var lblDateTimeCreated: UILabel!
    
    override
    public func awakeFromNib() {
        super.awakeFromNib()
    }

}
