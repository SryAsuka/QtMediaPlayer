# QtMediaPlayer
<div align="center">
<br>
<div>
    <img alt="C++" src="https://img.shields.io/badge/c++-20-%2300599C?logo=cplusplus">
    <img alt="QT" src="https://img.shields.io/badge/Qt-6.5-green?logo=QT">
</div>
<div>
    <img alt="platform" src="https://img.shields.io/badge/platform-Linux-blueviolet">
    <img alt="license" src="https://img.shields.io/badge/Lincense-GPLv3-blue.svg">
</div>
<br>
</div>

## 初步界面设计
  ### 主界面
  
  主界面模型图 ：模仿Windows的Mediaplayer布局
  <div align = "center">
      <img src= "introduce/picture/main_page.png" width = 600>
  </div>
  
  主界面原型图
  <div align = "center">
      <img src= "introduce/picture/main_pro.png" width = 600>
  </div>
  
   - Header View ：实现主界面、播放界面、设置和及介绍界面的切换
   - MainPage ：标题栏,右侧 "Open File" 可打开(*.mp4,*.avi,*.mkv)等视频文件
   - RecentVideos GridView ：点击视频预览图，将会索引视频所在位置所有视频，呈现在RecommendVideos GridView中
   - RecommendVideos GridView : 点击视频预览图，将会自动切换界面，播放视频
  
  ### 视频界面

  视频界面模型图
    <div align = "center">
      <img src= "introduce/picture/player_page.png" width = 600>
  </div>
  

  视频界面原型图
  <div align = "center">
      <img src= "introduce/picture/player_pro.png" width = 600>
  </div>

   - 鼠标移动呼出Videocontrol和VideoTitle
   - 鼠标触碰呼出音量控件和字幕控件和弹幕控件
   - 点击播放列表弹出列表界面，ListView双击可选择视频
   - 拖动控制条可以控制时间
  
  ### 设置及其介绍界面

  过于简单，未设置模型图与原型图。
  
## 开发说明文档
  
下载文档 [development_info_doc.docx](https://github.com/SryAsuka/QtMediaPlayer/blob/main/introduce/document/development_info_doc.docx)

## 用户说明文档

下载文档 [user_use_introduce_doc.docx](https://github.com/SryAsuka/QtMediaPlayer/blob/main/introduce/document/User_Introduction.docx)
    
## 致谢
  - 参考源码 [Harnuna](https://invent.kde.org/multimedia/haruna)
  - Srt字幕解析库 [Simple, yet powerful C++ SRT Subtitle Parser Library](https://github.com/saurabhshri/simple-yet-powerful-srt-subtitle-parser-cpp)
  - 音量silder [balloon-slider](https://github.com/realmahdi/balloon-slider)
  - 图像处理 [FFmpeg](https://github.com/FFmpeg/FFmpeg)

  ### 参与者
  
  [![Contributors](https://contributors-img.web.app/image?repo=SryAsuka/QtMediaPlayer)](https://github.com/SryAsuka/QtMediaPlayer/graphs/contributors)
  
## 介绍视频

 下载视频 [video_introduce](https://github.com/SryAsuka/QtMediaPlayer/blob/main/introduce/video/video_introduce_lixinhang.mkv)
  

