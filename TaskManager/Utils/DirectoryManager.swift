
import Foundation
import UIKit

class DirectoryManager{
  class  func writeImageToPath(_ path:String, image:UIImage) {
           let uploadURL = URL.createFolder(folderName: "upload")!.appendingPathComponent(path)

           if !FileManager.default.fileExists(atPath: uploadURL.path) {
               print("File does NOT exist -- \(uploadURL) -- is available for use")
               let data = image.jpegData(compressionQuality: 0.8)
               do {
                   print("Write image")
                   try data!.write(to: uploadURL)
               }
               catch {
                   print("Error Writing Image: \(error)")
               }
           }
           else {
               print("This file exists -- something is already placed at this location")
           }
       }
}

extension URL {
    static func createFolder(folderName: String) -> URL? {
        let fileManager = FileManager.default
        // Get document directory for device, this should succeed
        if let documentDirectory = fileManager.urls(for: .documentDirectory,
                                                in: .userDomainMask).first {
            // Construct a URL with desired folder name
            let folderURL = documentDirectory.appendingPathComponent(folderName)
            // If folder URL does not exist, create it
            if !fileManager.fileExists(atPath: folderURL.path) {
                do {
                    // Attempt to create folder
                    try fileManager.createDirectory(atPath: folderURL.path,
                                                withIntermediateDirectories: true,
                                                attributes: nil)
                } catch {
                    // Creation failed. Print error & return nil
                    print(error.localizedDescription)
                    return nil
                }
            }
            // Folder either exists, or was created. Return URL
            return folderURL
        }
        // Will only be called if document directory not found
        return nil
    }
}
