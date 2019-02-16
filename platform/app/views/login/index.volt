{{ stylesheet_link("assets/bower/bootstrap/dist/css/bootstrap.min.css") }}
{{ stylesheet_link("assets/bower/font-awesome/css/font-awesome.min.css") }}
{{ stylesheet_link("css/login.css") }}
</head>
<body>
<div class="container login-form">
    <h2 class="login-title"><?php echo $t->_("login_index_h2_title"); ?></h2>
    <div class="panel panel-default">
        <div class="panel-body">
            <!--<form action="{{ url('login/start') }}" method="post">-->
            <div class="input-group login-userinput">
                <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                <input id="txtUser" type="text" class="form-control" name="email"
                       placeholder="<?php echo $t->_('login_index_input_email'); ?>">
            </div>
            <div class="input-group login-passwordinput">
                <span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
                <input id="txtPassword" type="password" class="form-control" name="password"
                       placeholder="<?php echo $t->_('common_password'); ?>">
            </div>
            <button id="popup-submit" class="btn btn-primary btn-block"><i class="fa fa-sign-in"></i> <?php echo $t->
                _("common_login"); ?>
            </button>
            <div id="popup-captcha"></div>
            <!--</form>-->
        </div>
    </div>
</div>
{% include "layouts/oldfooter.volt" %}
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
    console.log("qq");
    $.ajax({
        // 获取id，challenge，success（是否启用failback）
        url: "{{ url('login/captcha') }}?t=" + (new Date()).getTime(), // 加随机数防止缓存
        type: "get",
        dataType: "json",
        success: function(data) {
            console.log("qq");
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