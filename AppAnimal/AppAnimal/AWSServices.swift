//
//  AWSServices.swift
//  AppAnimal
//
//  Created by Bruno Brito on 22/08/15.
//  Copyright (c) 2015 renanjunior. All rights reserved.
//

import Foundation
import UIKit
import AWSS3

class AWSServices {
    
    class func upload(image: UIImage, callback: (urlImagem:String, error:NSError!) -> Void) {
        
        
        let fileName = NSProcessInfo.processInfo().globallyUniqueString.stringByAppendingString(".png")
        let filePath = NSTemporaryDirectory().stringByAppendingString("upload").stringByAppendingString(fileName)
        let imageData = UIImagePNGRepresentation(image)
        imageData!.writeToFile(filePath, atomically: true)
        
        /*let testFileURL1 = NSURL(fileURLWithPath: NSTemporaryDirectory().stringByAppendingPathComponent("temp"))
        let data = UIImageJPEGRepresentation(image, 0.5)
        data.writeToURL(testFileURL1!, atomically: true)*/
        
        let uploadRequest = AWSS3TransferManagerUploadRequest()
        uploadRequest.body = NSURL(fileURLWithPath: filePath)
        let currTime = CACurrentMediaTime()
        let nomePet = "iOS/animal_" + currTime.description + ".png"
        uploadRequest.key = nomePet
        uploadRequest.bucket = "irmaoanimal"
        
        let transferManager = AWSS3TransferManager.defaultS3TransferManager()
        
        transferManager.upload(uploadRequest).continueWithBlock { (task) -> AnyObject! in
            if let error = task.error {
                if error.domain == AWSS3TransferManagerErrorDomain as String {
                    if let errorCode = AWSS3TransferManagerErrorType(rawValue: error.code) {
                        switch (errorCode) {
                        case .Cancelled, .Paused:
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                //self.collectionView.reloadData()
                                print("upload() ok")
                            })
                            break;
                            
                        default:
                            print("Erro case - upload() failed: [\(error)]")
                            callback(urlImagem: "", error: error)
                            break;
                        }
                    } else {
                        print("Erro code - upload() failed: [\(error)]")
                        callback(urlImagem: "", error: error)
                    }
                } else {
                    print("Erro domain - upload() failed: [\(error)]")
                    callback(urlImagem: "", error: error)
                }
            }
            
            if let exception = task.exception {
                print("upload() failed: [\(exception)]")
            }
            
            if task.result != nil {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    /*if let index = self.indexOfUploadRequest(self.uploadRequests, uploadRequest: uploadRequest) {
                        self.uploadRequests[index] = nil
                        self.uploadFileURLs[index] = uploadRequest.body
                        
                        let indexPath = NSIndexPath(forRow: index, inSection: 0)
                        self.collectionView.reloadItemsAtIndexPaths([indexPath])
                    }*/

                    let urlImagem = "https://s3-sa-east-1.amazonaws.com/irmaoanimal/" + nomePet
                    print(urlImagem)
                    
                    callback(urlImagem: urlImagem, error: nil)
                })
            }
            
            return nil
        }

    }
    
}
