<div class="index_dialog" id="loginDlg" style="display: none;">
    <div class="dlg_close"></div>
    <div class="dlg_title">登录</div>
    <div class="login" style="">
        <div class="login_div login_input_div">
            <span class="login_span user_name"></span>
            <input type="text" id="txtUser" class="login_input" placeholder="请输入账号">
        </div>
        <div class="login_div login_input_div">
            <span class="login_span user_pwd"></span>
            <input type="password" id="txtPassword" class="login_input" placeholder="请输入密码">
        </div>
        <!--<div class="login_div">-->
        <!--<div style="display: inline-block; float: left;">-->
        <!--<input type="checkbox" style="vertical-align: middle; margin-right: 5px;"><label>记住账户</label>-->
        <!--</div>-->
        <!--<div style="display: inline-block; float: right;"><span style="color: #0177f2; cursor: pointer;">忘记密码？</span></div>-->
        <!--</div>-->
        <div class="login_div" style="text-align: center;">
            <button type="button" id="popup-submit" class="login_button">登录</button>
        </div>
        <div id="popup-captcha"></div>
    </div>
</div>

<script type="text/javascript">
    $(function(){
        //点击课程
        $("#titleCurse, #login").bind("click", function(){
            //如果已经登录，直接跳转到课程页面
            {% if username %}
            window.location.href = "{{ url('index/courses') }}";
            {% else %}
            var windowWidth = $(window).width();
            $("#loginDlg").css("left", (windowWidth - 550)/2 )
            $("#loginDlg").show();
            {% endif %}
        })

        //点击登录dlg的关闭icon
        $(".dlg_close").bind("click", function() {
            $(this).parent(".index_dialog").hide();
        })
    })

</script>
<script src="http://static.geetest.com/static/tools/gt.js"></script>
<script>
    var handlerPopup = function (captchaObj) {
        $("#popup-submit").click(function () {
            var validate = captchaObj.getValidate();
            if (!validate) {
                alert('请先完成验证！');
                return;
            }
            $.ajax({
                url: "{{ url('login/start') }}", // 进行二次验证
                type: "post",
                dataType: "json",
                data: {
                    // 二次验证所需的三个值
                    geetest_challenge: validate.geetest_challenge,
                    geetest_validate: validate.geetest_validate,
                    geetest_seccode: validate.geetest_seccode,
                    email: $("#txtUser").val(),
                    password: $("#txtPassword").val()
                },
                success: function (result) {
                    console.log(result);
                    if (result.auth == 1) {
                        if (result.status == 1) {
                            var url = "{{ url('" + result.url + "')}}";
                            console.log(url);
                            window.location.href = url;
                        } else if(result.status == 2) {
                            alert('账号被禁止登陆！');
                        } else {
                            alert('邮箱或者密码不正确！');
                        }
                    } else {
                        alert('No auth！');
                    }
                    console.log(result.auth);
                }
            });
        });
        // 弹出式需要绑定触发验证码弹出按钮
        captchaObj.bindOn("#popup-submit");
        // 将验证码加到id为captcha的元素里
        captchaObj.appendTo("#popup-captcha");
        // 更多接口参考：http://www.geetest.com/install/sections/idx-client-sdk.html
    };
    $.ajax({
        // 获取id，challenge，success（是否启用failback）
        url: "{{ url('login/captcha') }}?t=" + (new Date()).getTime(), // 加随机数防止缓存
        type: "get",
        dataType: "json",
        success: function(data) {
            // 使用initGeetest接口
            // 参数1：配置参数
            // 参数2：回调，回调的第一个参数验证码对象，之后可以使用它做appendTo之类的事件
            initGeetest({
                gt: data.gt,
                challenge: data.challenge,
                product: "popup", // 产品形式，包括：float，embed，popup。注意只对PC版验证码有效
                offline: !data.success // 表示用户后台检测极验服务器是否宕机，一般不需要关注
            }, handlerPopup);
        }
    });
</script>