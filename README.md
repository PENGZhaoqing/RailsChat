# RailsChat

RailsChat是一款由Rails开发的实时Web聊天室，在[Render_sync Gem](https://github.com/chrismccord/render_sync)的基础上完成，有需要即时通讯的应用可以考虑这个Example

## 目前功能

* 即时通讯
* 增添好友
* 创建聊天
* 拉人，删人
* 转移房屋权限

## To Do

1. UI界面修改（类似WeChat）
2. 未读信息的提醒（包括声音）
3. 加入更多的ajax提高用户体验


## Usage 

1. Fork项目

  ```
  git clone https://github.com/your_user_name/RailsChat
  cd RailsChat
  bundle install
  rails server
  ```

2. 然后再打开另外一个终端，运行以下命令启动另外一个server来监听聊天室的用户并实时推送最新的消息：

```
rackup sync.ru -E production
```

### Note：如果要部署到云上或者本地局域网内，需要修改`config/sync.yml`文件

以本地局域网为例：

1. 若本机的ip地址为192.168.0.14（使用`ifconfig`查看），那么需要将config/sync.yml中的localhost全改为此ip地址，

2. 然后运行rake tmp:clear来清除缓存，不然修改不会生效（需要将所有相关的运行先停止：如rails s,rackup sync.ru等）

3. 再次运行rails服务器和监听程序，监听程序需要指定ip地址

  ```
  rails s
  rackup sync.ru -E production --host 192.168.0.14 
  ```

## 截图

<img src="/lib/Snip20170301_2.png">

<img src="/lib/Snip20170301_3.png">

<img src="/lib/Snip20170301_4.png">

<img src="/lib/Snip20170301_5.png">



**如果觉得好，请给项目点颗星来支持吧～～** 

有什么好的建议，请在issue中提出，欢迎contributors！

