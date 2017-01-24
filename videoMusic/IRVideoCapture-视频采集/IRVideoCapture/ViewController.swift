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
    
    // 视频输出队列
    fileprivate lazy var videoQueue = DispatchQueue.global()
    //音频输出队列
    fileprivate lazy var audioQueue = DispatchQueue.global()
    
    
    
    // 1.创建捕捉会话【一个session中可以添加多个Input】
    fileprivate lazy var session : AVCaptureSession = AVCaptureSession()
    
    // 4.给用户看到一个预览图层【可选】
    fileprivate lazy var previewLayer : AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session);
    
    fileprivate var videoOutput : AVCaptureVideoDataOutput?
    
    fileprivate var videoInput : AVCaptureDeviceInput?
    fileprivate var movieOutPut : AVCaptureMovieFileOutput?
}


// MARK: - 视频采集
extension ViewController{
    
    /// 开始采集
    @IBAction func starCapture(_ sender: Any) {
        //设置视频的输入&输出
        setupVideo()
        
        //设置音频的输入&输出
        setupAudio()
        
        // 3. 添加写入文件的output
        let movieOutput = AVCaptureMovieFileOutput()
        self.movieOutPut = movieOutput
        
        session.addOutput(movieOutput)
        
        // 3.1 设置写入的稳定性
        let connection = movieOutput.connection(withMediaType: AVMediaTypeVideo)
        connection?.preferredVideoStabilizationMode = .auto
        
        // 4.给用户看到一个预览图层【可选】
        previewLayer.frame = view.bounds
        view.layer.insertSublayer(previewLayer, at: 0)
        
        // 5.开始采集
        session.startRunning()
        // 6.开始将采集到的文件写入到文件中
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/abc.mp4"
        let url = URL(fileURLWithPath: path)
        
        movieOutput.startRecording(toOutputFileURL: url, recordingDelegate: self)
    }
    /// 停止采集
    @IBAction func stopCapture(_ sender: Any) {
        //结束写入文件
        self.movieOutPut?.stopRecording()

        session.stopRunning()
        previewLayer.removeFromSuperlayer()
    }
    
    
    /// 切的前后摄像头
    @IBAction func switchScene(){
        // 1. 获取之前的镜头
        guard var position = videoInput?.device.position else { return }
        
        // 2. 获取当前应该显示的镜头 
        position = position == .front ? .back : .front
        
        // 3. 根据当前镜头创建新的Device
        let devices = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo) as? [AVCaptureDevice]
        
        
        guard let device = devices?.filter({ $0.position == position }).first else { return }
        
        // 4. 根据新的Device创建Input
        guard let newVideoInput = try? AVCaptureDeviceInput(device: device) else { return }
        
        
            
        // 5. 在session中切的input
        session.beginConfiguration()
        session.removeInput(self.videoInput)
        session.addInput(newVideoInput)
        session.commitConfiguration()
        self.videoInput = newVideoInput
    }
}
extension ViewController{
    fileprivate func setupVideo(){
        // 2. 给捕捉会话设置输入源【摄像头】
        // 2.1 获取摄像头设备【前后都包含】
        guard let devices = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo) as? [AVCaptureDevice] else {
            print("摄像头不可用")
            return
        }
        
        //        let device = devices.filter { ( device : AVCaptureDevice) -> Bool in
        //            return device.position == .front
        //        }.first
        
        // 2.2 通过$0取出第一个属性【前置摄像头 】
        guard let device = devices.filter({ $0.position == .front }).first else { return }
        
        // 2.3 通过device创建AVCaptureInput对象
        guard let videoInput = try? AVCaptureDeviceInput(device: device) else { return }
        self.videoInput = videoInput
        
        // 2.4 将input添加到会话中
        session.addInput(videoInput)
        
        // 3.给捕捉会话设置输出源
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: videoQueue)
        session.addOutput(videoOutput)
//        self.videoOutput = videoOutput
        
        // 获取video对象的connection
//        let connection = videoOutput.connection(withMediaType: AVMediaTypeVideo)
        self.videoOutput = videoOutput
        
    }
    
    fileprivate func setupAudio(){
        // 1.设置音频的输入【话筒】
        // 1.1获取话筒设备
        guard let device = AVCaptureDevice.devices(withMediaType: AVMediaTypeAudio).first as? AVCaptureDevice else { return }
        
        // 1.2 根据device创建AVCaptureInput
        guard let audioInpu = try? AVCaptureDeviceInput(device: device ) else { return }
        
        // 1.3 将Input添加到会话中
        session.addInput(audioInpu)
        
        // 2.给会话设置音频的输出源
        let audioOutput = AVCaptureAudioDataOutput()
        audioOutput.setSampleBufferDelegate(self, queue: audioQueue)
        session.addOutput(audioOutput)
    }
}

// MARK: - 【遵守视频代理协议】获取数据
extension ViewController : AVCaptureVideoDataOutputSampleBufferDelegate,AVCaptureAudioDataOutputSampleBufferDelegate {
    
    /// 采集到的每一帧数据
    ///
    /// - Parameters:
    ///   - sampleBuffer: 存储采集到的所有帧数据【需要美颜和编码处理就是对他进行处理】
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        if connection == self.videoOutput?.connection(withMediaType: AVMediaTypeVideo) {
            print("+++++采集到视频画面")
        }else{
            print("~~~~~采集到音频画面")
        }
        
    }
}


// MARK: - 写入文件协议
extension ViewController : AVCaptureFileOutputRecordingDelegate{
    func capture(_ captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAt fileURL: URL!, fromConnections connections: [Any]!) {
        print("开始写入文件")
    }
    func capture(_ captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAt outputFileURL: URL!, fromConnections connections: [Any]!, error: Error!) {
        print("结束写入文件")
    }
}
