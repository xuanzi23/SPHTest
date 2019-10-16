import Foundation
import Alamofire
import Toast_Swift

class APIManager: NSObject {
    
    class func callAPI(view:UIView, type: Alamofire.HTTPMethod, requestPath:String, queryString:String, parameters: Parameters, showAlert: Bool = false, OnSuccess: @escaping (AnyObject?, Int) -> (), OnFailure: @escaping (AnyObject?, NSError?) -> ()){
        
        view.makeToastActivity(.center)
        
        var url = ""
        
        if(queryString == ""){
            url = GlobalVariable().link + requestPath
        }else{
            url = GlobalVariable().link + requestPath + queryString
        }
        
        print("URL",url)
        
        Alamofire.request(url,method: type, parameters:parameters ).responseJSON{
            response in
            
            switch response.result{
            case .success(let data):
                OnSuccess(data as AnyObject?, (response.response?.statusCode)!)
                //view.hideAllToasts()
                view.hideToastActivity()
                break
            case .failure(let error):
                OnFailure(nil,error as NSError?)
                view.hideToastActivity()
                if(showAlert){
                    print("show alert",error.localizedDescription)
                    var topController:UIViewController = UIApplication.shared.keyWindow!.rootViewController!
                    while ((topController.presentedViewController) != nil) {
                        topController = topController.presentedViewController!;
                    }
                    let alertController = UIAlertController(title: error.localizedDescription, message: "", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(OKAction)
                    topController.present(alertController, animated:true, completion:nil)
                }
                break
            }
        }
    }
}
