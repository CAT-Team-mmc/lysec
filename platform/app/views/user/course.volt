{% include "layouts/detail_header.volt" %}
</div>
<div class="detial-body">
    <div class="part1 box-shadow-detial clearfix">
        <img src="../../imgs/img_detail.png"/>
        <ul>
            {% if course %}
            <li>{{ course.name|e }}</li>
            <li>{{ course.description|e }}</li>
            <li>
                <a href="#" id="deployBtn" onclick="beginDeploy({{ course.id }})">开始部署</a>
                <span id="warn_info"
                      style="color: #cc0101; font-size: 15px; margin-left: 15px; display: none;">没有部署权限！</span>
                <div class="detail-progressBar" style="display: none;">
                    <div id="detail-bar"></div>
                </div>
            </li>
            <!--<li><a href="{{ url('user/deploy') }}/{{ course.id }}">开始部署</a></li>-->
            {% endif %}
        </ul>
    </div>
    <div class="tab-menu clearfix" id="menuTab">
        {% if report %}<span class="on"><em></em>课程报告</span>{% endif %}
        {% if analysis %}<span><em></em>课程分析</span>{% endif %}
        {% if afterclass %}<span><em></em>课后拓展</span>{% endif %}
    </div>
    <div class="content" id="content">
        <div style="display:block;">{% if report %}{{ report }}{% endif %}</div>
        <div>{% if analysis %}{{ analysis }}{% endif %}</div>
        <div>{% if afterclass %}{{ afterclass }}{% endif %}</div>
    </div>
</div>
{{ javascript_include("assets/bower/jquery/dist/jquery.min.js") }}
{% include "layouts/footer.volt" %}
{% include "layouts/common_login.volt" %}
<script>
    var oMenu = document.getElementById('menuTab');
    var aSpan = oMenu.getElementsByTagName('span');
    var oContent = document.getElementById('content');
    var aUl = oContent.getElementsByTagName('div');
    for (var i = 0; i < aSpan.length; i++) {
        aSpan[i].setAttribute('index', i);
        aSpan[i].onclick = function () {
            var _index = this.getAttribute('index');
            for (var j = 0; j < aSpan.length; j++) {
                aSpan[j].className = '';
                aUl[j].style.display = 'none';
            }
            this.className = 'on';
            aUl[_index].style.display = 'block';
        };
    }
    var userBox = document.getElementById('uName');
    var userInfo = document.getElementById('userInfo');
    userInfo.onmouseover = function () {
        userInfo.style.display = 'block';
    };
    userBox.onmouseover = function () {
        userInfo.style.display = 'block';
    };
    userInfo.onmouseout = function () {
        userInfo.style.display = 'none';
    };
    userBox.onmouseout = function () {
        userInfo.style.display = 'none';
    };
    //点击开始部署，展示进度条
    function beginDeploy(id) {
        //如果不能部署，则进行提示
        var address = "";
        var status = "";
        $.get("{{url("user/deploy")}}/" + id, function (data) {
            address = data.address;
            status = data.status;
            var message = data.message;
            if (status == 10001 || status == 10002) {
                $("#warn_info").text(message);
                $("#warn_info").show();
                return;
            }

            $("#deployBtn").hide();
            $(".detail-progressBar").show();
            //初始化js进度条
            $("#detail-bar").css("width", "0px");
            //进度条的速度，越小越快
            var speed = 50;

            bar = setInterval(function () {
                nowWidth = parseInt($("#detail-bar").width());
                //宽度要不能大于进度条的总宽度
                if (nowWidth <= 380) {
                    barWidth = (nowWidth + 1) + "px";
                    $("#detail-bar").css("width", barWidth);
                } else {
                    //进度条读满后，停止
                    clearInterval(bar);
                    if (address != "" && address != undefined) {
                        window.location.href = "http://" + address;
//                var a = $("<a id='newLink' href='" + address + "' target='_blank' style='display: none;'>部署</a>").appendTo($("body"));
//                $("#newLink").click();
//                a.remove();
                    }
                }
            }, speed);
            });
        }
</script>
