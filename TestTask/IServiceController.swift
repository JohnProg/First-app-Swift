import Foundation

protocol IServiceController {
    func viewIsReady()
    func attachView(newView: IServiceView)
}
