import UIKit
import ImageSlideshow


class GalleryViewController: UIViewController {

    @IBOutlet weak var imageSlideshow: ImageSlideshow!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    }
    
}
