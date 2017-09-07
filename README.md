# RailsChat 

RailsChat是一款由Rails开发的实时Web聊天室，在[Render_sync](https://github.com/chrismccord/render_sync)的基础上完成，有需要即时通讯的应用可以考虑这个Example

## Online Demo

![demo](demo.gif)

请点击[这里](http://139.129.209.63:44400/)访问Demo，测试用户登陆账号格式为：

```
username: user<number>@test.com
password: password
```

* 其中number为1到20，代表20个用户，例如使用`user1@test.com`和`password`能登陆用户1，以此类推

Note：请用两个浏览器分别登陆不同的用户来测试消息的即使推送，注意这两个用户需要互为好友

## 目前功能

* 聊天室消息即时推送
* 支持查找，添加，删除好友
* 创建私人聊天，也支持多人聊天
* 房主可以拉人，踢人
* 房主能转移房屋权限

## Todo

1. 现在的即时推送只限于聊天的消息，其他的推送比如未读信息提醒（包括声音）等还未涉及
2. 添加好友需要对方同意，现在是单方面添加
3. 用户个人简介还未开发
4. UI界面修改（类似WeChat）
5. 管理后台开发

## Usage 

### [RailsChat详细教程-传送门](http://blog.csdn.net/ppp8300885/article/details/59109778)

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

1. 若本机的ip地址为192.168.0.14（使用`ifconfig`查看），那么需要将config/sync.yml中的localhost全改为此ip地址，例如
 
 ```
  development:
    server: "http://192.168.0.14:9292/faye"
    adapter_javascript_url: "http://192.168.0.14:9292/faye/faye.js"
    auth_token:  "97c42058e1466902d5adfac0f83e84c1794b9c3390e3b0824be9db8344eae82b"
    adapter: "Faye"
    async: true
    
  test:
    ...
  production:
    ...
  ```

2. 然后运行rake tmp:clear来清除缓存，不然修改不会生效（运行前先将所有相关的运行停止：如rails s,rackup sync.ru等）

3. 再次运行rails服务器和监听程序，并指定监听程序运行的ip地址

  ```
  rails s
  bundle exec rackup sync.ru -E production --host 192.168.0.14 
  ```

### Tips:

1. 在服务器中可以后台运行rack：`bundle exec rackup sync.ru -E production --host 192.168.0.14 -D`
2. 若要关闭在后台运行的rackup，请使用`ps ax | grep ruby`查找相关ruby端口，然后用`kill －9 <pid>`结束正在运行的rackup，如：

```
21099 ?        Sl     0:00 /var/www/railschat/RailsChat/vendor/bundle/ruby/2.3.0/bin/rackup                                    
21105 pts/4    S+     0:00 grep --color=auto ruby
```
  



## Debug

1. 当遇到消息并没有实时推送的情况时，先F12查看浏览器的Js文件加载情况，若faye.js加载成功则一般不会出现问题

2. 以上加载完成但是仍然没有推送的时候，请查看Rails服务器的log文件

3. 需要在两个浏览器中登录不同的账号来检验聊天室功能


## 截图

<img src="/lib/Snip20170301_2.png">

<img src="/lib/Snip20170301_3.png">

<img src="/lib/Snip20170301_4.png">

<img src="/lib/Snip20170301_5.png">



**如果觉得好，请给项目点颗星来支持吧～～** 

有什么好的建议，请在issue中提出，欢迎contributors！

