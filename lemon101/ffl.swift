
//  Created by Jim Hsu on 2021/6/22.
//

import Foundation
import OSLog

fileprivate let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "ffl")
 
enum LogLevel:CaseIterable{
    case debug, info, notice, error, fault
}

/* ** filedebugLevelDict */
fileprivate let fileDubugLevelDict:[String:Int] = [
    "AppDelegate":2, "contentView": 2,
    "Store": 2
]

fileprivate let debugThreashold:Int = 1
/** if not found will show, so that new class will always debug */
fileprivate func classDebugFilter(fname:String) -> Bool {
    if let matchedLevel = fileDubugLevelDict[fname]{
        return matchedLevel <= debugThreashold
    }else{
        return true
    }
}

func ffl(_ message: String, _ logLevel:LogLevel = .debug, file: String = #file, function: String = #function, line: Int = #line ) {
    //let shortFileName = URL(string: file)!.deletingPathExtension().lastPathComponent
    //this is only to test the oslog retrieve
    let fname = URL(string: file)!.deletingPathExtension().lastPathComponent
    let printIt:Bool = logLevel == .debug ?  classDebugFilter(fname: fname) : true
    #if targetEnvironment(simulator)
    if printIt{
        print("~\(fname) !\(line) @\(function): \(message)")
    }
    #else
        switch logLevel{
        case .debug:
            if printIt{
                print("~\(fname) !\(line) @\(function): \(message)")
            }
        case .info:
            print("~\(fname) !\(line) @\(function): \(message)")
        case .notice:
            print("~\(fname) !\(line) @\(function): \(message)")
            logger.notice("ln\(line) \(function): \(message, privacy:.public)")
        case .error:
            print("~\(fname) !\(line) @\(function): \(message)")
            logger.error("ln\(line) \(function): \(message, privacy:.public)")
        case .fault:
            print("~\(fname) !\(line) @\(function): \(message)")
            logger.fault("ln\(line) \(function): \(message, privacy:.public)")
        @unknown default:
            logger.notice("ln\(line) \(function): \(message, privacy:.public)")
        }
    #endif
}

func ffl(_ count: Int, _ logLevel:LogLevel = .notice, file: String = #file, function: String = #function, line: Int = #line ) {
    let fname = URL(string: file)!.deletingPathExtension().lastPathComponent
    let message = count.description
    #if targetEnvironment(simulator)
    let printIt:Bool = logLevel == .debug ?  classDebugFilter(fname: fname) : true
    if printIt{
        print("~\(fname) !\(line) @\(function): \(message)")
    }
    #else
        switch logLevel{
        case .debug, .info:
            print("~\(fname) \(line) \(function): \(message)")
        case .notice:
            logger.notice("\(line) \(function): \(message, privacy:.public)")
        case .error:
            logger.error("\(line) \(function): \(message, privacy:.public)")
        case .fault:
            logger.fault("\(line) \(function): \(message, privacy:.public)")
        @unknown default:
            logger.notice("\(line) \(function): \(message, privacy:.public)")
        }
    #endif
}
