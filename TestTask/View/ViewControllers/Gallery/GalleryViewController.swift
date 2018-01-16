import UIKit
import ImageSlideshow


class GalleryViewController: UIViewController {

    @IBOutlet weak var imageSlideshow: ImageSlideshow!
    @IBOutlet weak var btnLeft: UIBarButtonItem!
    @IBOutlet weak var btnRight: UIBarButtonItem!
    
    private var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initImageSladeshow()
    }
    
    private func initImageSladeshow() {
        imageSlideshow.backgroundColor = UIColor.white
        imageSlideshow.pageControlPosition = PageControlPosition.underScrollView
        imageSlideshow.pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        imageSlideshow.pageControl.pageIndicatorTintColor = UIColor.black
        imageSlideshow.contentScaleMode = UIViewContentMode.scaleAspectFit
        imageSlideshow.activityIndicator = DefaultActivityIndicator()
        imageSlideshow.zoomEnabled = true
        imageSlideshow.circular = false
        imageSlideshow.preload = ImagePreload.fixed(offset: 1)
        
        imageSlideshow.setImageInputs(GalleryImages.images as! [InputSource])
        
        imageSlideshow.currentPageChanged = { page in
            self.currentPage = page
        }
    }
    
    @IBAction func ClickLeftBtn(_ sender: Any) {
        let newPage = currentPage - 1
        if newPage >= 0 {
            currentPage = newPage
            imageSlideshow.setCurrentPage(currentPage, animated: true)
        }
    }
    
    @IBAction func ClickRightBtn(_ sender: Any) {
        let newPage = currentPage + 1
        if newPage < imageSlideshow.images.count {
            currentPage = newPage
            imageSlideshow.setCurrentPage(currentPage, animated: true)
        }
    }
}
