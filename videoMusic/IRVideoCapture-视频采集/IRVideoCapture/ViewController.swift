//
//  ViewController.swift
//  IRVideoCapture
//
//  Created by zhongdai on 2017/1/23.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    fileprivate lazy var videoQueue = DispatchQueue.global()
    
    fileprivate lazy var session : AVCaptureSession = AVCaptureSession()
    
    fileprivate lazy var previewLayer : AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session);
    
}


// MARK: - 视频采集
extension ViewController{
    
    /// 开始采集
    @IBAction func starCapture(_ sender: Any) {
        // 1.创建捕捉会话
//        let session = AVCaptureSession()
        
        // 2.给捕捉会话设置输入源【摄像头】
        //获取摄像头设备【前后都包含】
        guard let devices = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo) as? [AVCaptureDevice] else {
            print("摄像头不可用")
            return
        }
        
//        let device = devices.filter { ( device : AVCaptureDevice) -> Bool in
//            return device.position == .front
//        }.first
        
        //通过$0取出第一个属性【前置摄像头 】
        guard let device = devices.filter({ $0.position == .front }).first else { return }

        // 通过device创建AVCaptureInput对象
        guard let videoInput = try? AVCaptureDeviceInput(device: device) else { return }
        
        //将input添加到会话中
        session.addInput(videoInput)
        
        // 3.给捕捉会话设置输出源
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: videoQueue)
        session.addOutput(videoOutput)
        
        // 4.给用户看到一个预览图层【可选】
//        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = view.bounds
//        view.layer.addSublayer(previewLayer)
        view.layer.insertSublayer(previewLayer, at: 0)
        
        // 5.开始采集
        session.startRunning()
    }
    /// 停止采集
    @IBAction func stopCapture(_ sender: Any) {
        
        session.stopRunning()
        previewLayer.removeFromSuperlayer()
    }
}
extension ViewController : AVCaptureVideoDataOutputSampleBufferDelegate {
    
    /// 采集到的每一帧数据
    ///
    /// - Parameters:
    ///   - captureOutput: <#captureOutput description#>
    ///   - sampleBuffer: 存储采集到的所有帧数据【需要美颜和编码处理就是对他进行处理】
    ///   - connection: <#connection description#>
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        print("已经采集到画面")
        
    }
}
