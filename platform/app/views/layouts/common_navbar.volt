<div class="top">
    <div class="top-body clearfix">
        <a href="{{ url('index') }}"><div class="logo fl"></div></a>
        <div class="info fr" style="float:left; width: 580px;">
            <a href="https://lysec.github.io/">博客</a>
            <a href="{{ url('index/qa') }}">问与答</a>
            <a href="javascript:;" id="titleCurse">课程</a>
        </div>
        <div class="info fr" style="float:right;">
            {% if username %}
            <span id="uName">{{ username |e }}</span>
            <div class="user-info" id="userInfo" style="display:none;">
                <a href="{{ url('user/running') }}">运行中的服务</a>
                <a href="{{ url('user/profile') }}">资料</a>
                <a href="{{ url('login/end') }}">登出</a>
            </div>
            {% else %}
                <a href="javascript:;" id="login" class="bg_green bg_radius_3">登录</a>
            {% endif %}
        </div>
    </div>
</div>