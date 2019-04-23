//
//  ViewController.swift
//  B99
//
//  Created by Apple on 30/03/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    
    var sounds=[NSString]()
    var AudioPlayer: AVAudioPlayer?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sounds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "holtCell", for: indexPath) as! HoltTableViewCell
        cell.label1.text="\(indexPath.row+1)"
        cell.label2.text=sounds[indexPath.row] as String
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSongs()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do{
            if let fileURL = Bundle.main.path(forResource :"\(sounds[indexPath.row])",ofType: "m4a"){
                AudioPlayer=try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL))
                AudioPlayer?.play()
            }
        }
        catch{
            
        }
    }
    
    func getSongs(){
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        do{
            let items : [NSString] = try fm.contentsOfDirectory(atPath: path) as [NSString]
            for item in items{
                if item.pathExtension == "m4a"{
                    sounds.append(item.deletingPathExtension as NSString)
                    
                }
            }
        }catch{
            print(error.localizedDescription)
        }
    }
}

