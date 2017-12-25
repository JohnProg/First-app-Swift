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
        imageSlideshow.circular = false
        
        imageSlideshow.setImageInputs(GalleryImages.images as! [InputSource])
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(GalleryViewController.didTap))
        imageSlideshow.addGestureRecognizer(recognizer)
    }

    @objc func didTap() {
        let fullScreenController = imageSlideshow.presentFullScreenController(from: self)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
    
}
