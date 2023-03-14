//
//  HttpUtility.swift
//  Namita_iOS_Developer_Tasks
//
//  Created by Admin on 13/03/23.
//

import Foundation
import RappleProgressHUD

struct HttpUtility
{
    func putMethod<T:Decodable>(requestUrl: URL, uploadDataModel: UpdateProductRequest, isHud:Bool, resultType: T.Type,completionHandler:@escaping(_ result: T?)-> Void) {
        if isHud {
            showHud()
        }
        // Convert model to JSON data
        guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
            MessageView.showMessage(message: ErrorMessage.errorConvertingModel, time: 1.7, verticalAlignment: .bottom)
            return
        }
        
        // Create the request
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        URLSession.shared.dataTask(with: request) { data, response, error in
            hideHud()
            guard error == nil else {
                DispatchQueue.main.async {
                    MessageView.showMessage(message: ErrorMessage.errorCallingPutAPI, time: 1.7, verticalAlignment: .bottom)
                }
                print(error!)
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    MessageView.showMessage(message: ErrorMessage.errorDataNotReceived, time: 1.7, verticalAlignment: .bottom)
                }
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                DispatchQueue.main.async {
                    MessageView.showMessage(message: ErrorMessage.requestFailed, time: 1.7, verticalAlignment: .bottom)
                }
                return
            }
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    DispatchQueue.main.async {
                        MessageView.showMessage(message: ErrorMessage.errorJsonConversion, time: 1.7, verticalAlignment: .bottom)
                    }
                    return
                }
                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                    DispatchQueue.main.async {
                        MessageView.showMessage(message: ErrorMessage.errorPrettyJsonConversion, time: 1.7, verticalAlignment: .bottom)
                    }
                    return
                }
                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                    DispatchQueue.main.async {
                        MessageView.showMessage(message: ErrorMessage.errorPrintError, time: 1.7, verticalAlignment: .bottom)
                    }
                    return
                }
                
                print(prettyPrintedJson)
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(resultType, from: data)
                    print(result)
                    _=completionHandler(result)
                }
                catch let error{
                    debugPrint("error occured while decoding = \(error.localizedDescription)")
                }
            } catch {
                MessageView.showMessage(message: ErrorMessage.errorJsonConversion, time: 1.7, verticalAlignment: .bottom)
                return
            }
        }.resume()
    }
    
    func deleteMethod<T:Decodable>(requestUrl: URL, isHud:Bool, resultType: T.Type,completionHandler:@escaping(_ result: T?)-> Void) {
        if isHud {
            showHud()
        }
        // Create the request
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "delete"
        URLSession.shared.dataTask(with: request) { data, response, error in
            hideHud()
            guard error == nil else {
                print("Error: error calling DELETE")
                print(error!)
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    MessageView.showMessage(message: ErrorMessage.errorDataNotReceived, time: 1.7, verticalAlignment: .bottom)
                }
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                DispatchQueue.main.async {
                    MessageView.showMessage(message: ErrorMessage.requestFailed, time: 1.7, verticalAlignment: .bottom)
                }
                return
            }
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    DispatchQueue.main.async {
                        MessageView.showMessage(message: ErrorMessage.errorJsonConversion, time: 1.7, verticalAlignment: .bottom)
                    }
                    return
                }
                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                    DispatchQueue.main.async {
                        MessageView.showMessage(message: ErrorMessage.errorPrettyJsonConversion, time: 1.7, verticalAlignment: .bottom)
                    }
                    return
                }
                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                    DispatchQueue.main.async {
                        MessageView.showMessage(message: ErrorMessage.errorPrintError, time: 1.7, verticalAlignment: .bottom)
                    }
                    return
                }
                
                print(prettyPrintedJson)
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(resultType, from: data)
                    print(result)
                    _=completionHandler(result)
                }
                catch let error{
                    debugPrint("error occured while decoding = \(error.localizedDescription)")
                }
            } catch {
                MessageView.showMessage(message: ErrorMessage.errorJsonConversion, time: 1.7, verticalAlignment: .bottom)
                return
            }
        }.resume()
    }
    
    func getApiData<T:Decodable>(requestUrl: URL,isHud:Bool, resultType: T.Type, completionHandler:@escaping(_ result: T?)-> Void)
    {
        if isHud {
            showHud()
        }
        //.......APP HEADER "BASIC AUTH"
        //......Creating urlRequest.........
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = "get"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        URLSession.shared.dataTask(with: urlRequest) { (responseData, httpUrlResponse, error) in
            hideHud()
            if(error == nil && responseData != nil && responseData?.count != 0)
            {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(resultType, from: responseData!)
                    print(result)
                    _=completionHandler(result)
                }
                catch let error{
                    debugPrint("error occured while decoding = \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    func postMethod<T:Decodable>(requestUrl: URL, requestBody: UpdateProductRequest, resultType: T.Type, isHud:Bool,completionHandler:@escaping(_ result: T)-> Void) {
            
            // Convert model to JSON data
            guard let jsonData = try? JSONEncoder().encode(requestBody) else {
                print("Error: Trying to convert model to JSON data")
                return
            }
            // Create the url request
            var request = URLRequest(url: requestUrl)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
            request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
            request.httpBody = jsonData
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    print("Error: error calling POST")
                    print(error!)
                    return
                }
                guard let data = data else {
                    DispatchQueue.main.async {
                        MessageView.showMessage(message: ErrorMessage.errorDataNotReceived, time: 1.7, verticalAlignment: .bottom)
                    }
                    return
                }
                guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                    DispatchQueue.main.async {
                        MessageView.showMessage(message: ErrorMessage.requestFailed, time: 1.7, verticalAlignment: .bottom)
                    }
                    return
                }
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        DispatchQueue.main.async {
                            MessageView.showMessage(message: ErrorMessage.errorJsonConversion, time: 1.7, verticalAlignment: .bottom)
                        }
                        return
                    }
                    guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                        DispatchQueue.main.async {
                            MessageView.showMessage(message: ErrorMessage.errorPrettyJsonConversion, time: 1.7, verticalAlignment: .bottom)
                        }
                        return
                    }
                    guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                        DispatchQueue.main.async {
                            MessageView.showMessage(message: ErrorMessage.errorPrintError, time: 1.7, verticalAlignment: .bottom)
                        }
                        return
                    }
                    
                    print(prettyPrintedJson)
                    let decoder = JSONDecoder()
                    do {
                        let result = try decoder.decode(resultType, from: data)
                        print(result)
                        _=completionHandler(result)
                    }
                    catch let error{
                        debugPrint("error occured while decoding = \(error.localizedDescription)")
                    }
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }.resume()
        }
    
    // Swift Dictionary To Data.......................
    func convertDictionaryToData(dict:[String:Any])->Data{
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options:  JSONSerialization.WritingOptions.prettyPrinted)
            return jsonData
        }catch{
            print("erroMsg.........")
        }
        return Data()
    }
    
    //......... Data to Swift Dictionary..................
    func convertDataToJSONString(data: Data)->[String: Any]{
        do{
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else { return [:] }
            return json
        }catch{
            print("erroMsg.........")
        }
        return [:]
    }
    
    // MARK: Show progress hud
    func showHud() {
        let attribute = RappleActivityIndicatorView.attribute(style: RappleStyle(rawValue: RappleStyleCircle)!, tintColor: .blue, screenBG: UIColor.clear, progressBG: .black, progressBarBG: .lightGray, progreeBarFill: .yellow)
        RappleActivityIndicatorView.startAnimating(attributes: attribute)
    }
    func hideHud() {
        RappleActivityIndicatorView.stopAnimation(completionIndicator: .none, completionLabel: "", completionTimeout: 1.0)
    }
}
extension Data {
    mutating func appendString(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}
