//
//  RequestsManager.swift
//  ImageGallery
//
//  Created by Luís Vieira on 31/10/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

import Foundation

class RequestsManager {
    
    static let shared = RequestsManager()

    private lazy var queue: OperationQueue = OperationQueue()
    
    private init() {
        // Mandatory private init
    }
    
    func getPage(_ tag: String, _ page: Int, completion: @escaping (_ images: [SizesObject], _ error : NSError?) -> Void){
        
        var pageObject: PageObject?
        var images: [SizesObject] = []
        
        let pageOperation = BlockOperation {
            
            URLSession.shared.invalidateAndCancel()
            
            let group = DispatchGroup()
            
            group.enter()
            guard let request: URLRequest = RequestsBuilder.pageRequest(with: tag, and: String(describing: page)) else {
                OperationQueue.main.addOperation({
                    completion([], self.buildNSError("error_url_request"))
                })
                return
            }
            
            self.getData(request, completion: { data, error in
                
                if let error = error {
                    OperationQueue.main.addOperation({
                        completion([], error)
                    })
                    return
                }
                
                guard let data = data, let resultObject = try? JSONDecoder().decode(PageObject.self, from: data) else {
                    OperationQueue.main.addOperation({
                        completion([], self.buildNSError("error_json"))
                    })
                    return
                }
                
                pageObject = resultObject
                group.leave()
            })
            
            
            group.wait()
        }
        
        let imagesOperation = BlockOperation {
            
            let group = DispatchGroup()
            
            if let imageReferences = pageObject?.photos?.photo {
                
                for imageReference in imageReferences {
                    
                    group.enter()
                    
                    guard let imageId = imageReference.id, let request: URLRequest = RequestsBuilder.sizesRequest(with: imageId) else {
                        OperationQueue.main.addOperation({
                            completion([], self.buildNSError("error_url_request"))
                        })
                        return
                    }
                    
                    self.getData(request, completion: {data,error in
                        
                        if let error = error {
                            OperationQueue.main.addOperation({
                                completion([], error)
                            })
                            return
                        }
                        
                        guard let data = data, let resultObject = try? JSONDecoder().decode(SizeObject.self, from: data) else {
                            OperationQueue.main.addOperation({
                                completion([], self.buildNSError("error_json"))
                            })
                            return
                        }
                        
                        if let imageSizes = resultObject.sizes{
                            images.append(imageSizes)
                        }
                        
                        group.leave()
                    })
                }
                
                group.wait()
            }
            
            completion(images, nil)
        }
        
        //Add a dependency so the second operation only starts after the first one ends
        imagesOperation.addDependency(pageOperation)
        
        //Add both operations to the queue
        queue.addOperation(pageOperation)
        queue.addOperation(imagesOperation)
    }
    
    func getImage(_ urlString: String, completion: @escaping (_ data: Data?, _ error : NSError?) -> Void){
        
        URLSession.shared.invalidateAndCancel()
        
        guard let request = RequestsBuilder.singleImageRequest(with: urlString) else {
            OperationQueue.main.addOperation({
                completion(nil, self.buildNSError("error_url_request"))
            })
            return
        }
        
        self.getData(request, completion: { data, error in
            
            if let error = error {
                OperationQueue.main.addOperation({
                    completion(nil, error)
                })
                return
            }
            
            completion(data, nil)
        })
    }
    
    
    private func getData(_ request: URLRequest, completion: @escaping (_ data: Data?, _ error : NSError?) -> Void){
        
        guard let isConnected = try? Reachability()?.isConnectedToNetwork, isConnected == true else {
            OperationQueue.main.addOperation({
                completion(nil, self.buildNSError("error_no_connection"))
            })
            return
        }
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            if let _ = error {
                OperationQueue.main.addOperation({
                    completion(nil, self.buildNSError("error_response"))
                })
                return
            }
            
            guard let _ = response as? HTTPURLResponse else {
                OperationQueue.main.addOperation({
                    completion(nil, self.buildNSError("error_response"))
                })
                return
            }
            
            guard let data = data else {
                OperationQueue.main.addOperation({
                    completion(nil, self.buildNSError("error_response"))
                })
                return
            }
            
            OperationQueue.main.addOperation({
                completion(data, nil)
            })
            
        }).resume()
    }
    
    private func buildNSError(_ message: String) -> NSError {
        return NSError(domain: "app_name".overrideLocalizedString(), code: 0, userInfo: [NSLocalizedFailureReasonErrorKey: message])
    }
}
