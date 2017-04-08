//
//  FolderManager.swift
//  FolderManager
//
//  Created by qifx on 08/04/2017.
//  Copyright © 2017 Manfred. All rights reserved.
//

import UIKit

public class FolderManager {

    let rootURL: URL
    
    public var currentURL: URL
    
    
    /// Init a FolderManager
    ///
    /// - Parameter rootURL: as its name
    public init(rootURL: URL) {
        self.rootURL = rootURL
        currentURL = rootURL
    }
    
    
    /// get currentUrl's father, if exists.
    ///
    /// - Returns: currentUrl's father
    public func getParent() -> URL? {
        if currentURL == rootURL {
            return nil
        } else {
            let tempURL = currentURL
            return tempURL.deletingLastPathComponent()
        }
    }
    
    
    /// change currentUrl to its parent
    ///
    /// - Returns: result
    public func goToParent() -> Bool {
        if currentURL == rootURL {
            return false
        } else {
            currentURL.deleteLastPathComponent()
            return true
        }
    }
    
    
    /// get folderChilds and fileChilds
    ///
    /// - Returns: folder and file childs
    public func getChilds() -> ([URL], [URL]) {
        var fUrls = [URL]()
        var dUrls = [URL]()
        let fm = FileManager.default
        do {
            let paths = try fm.contentsOfDirectory(atPath: currentURL.path)
            let b: UnsafeMutablePointer<ObjCBool>? = nil
            for path in paths {
                if fm.fileExists(atPath: path, isDirectory: b) {
                    if b!.pointee.boolValue {
                        dUrls.append(URL.init(fileURLWithPath: path))
                    } else {
                        fUrls.append(URL.init(fileURLWithPath: path))
                    }
                }
            }
        } catch {}
        return (fUrls, dUrls)
    }
    
    
    /// change currentUrl to its one child
    ///
    /// - Parameter url: childUrl
    /// - Returns: result
    public func goToChild(url: URL) -> Bool {
        currentURL = url
        return true
    }
    
    public func createDirectory(name: String) -> URL? {
        let url = currentURL.appendingPathComponent(name)
        do {
            try FileManager.default.createDirectory(at: url, withIntermediateDirectories: false, attributes: nil)
            
        } catch {
            return nil
        }
        return url
    }
    
}
