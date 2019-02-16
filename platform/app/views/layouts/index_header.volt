{{ stylesheet_link("css/style.css") }}
</head>
<body class="ly-body">
<header>
    <div class="header_body clearfix">
        <div class="logo"></div>
        <div class="info fr">
            <a href="https://lysec.github.io/">博客</a>
            <a href="{{ url('index/qa') }}">问与答</a>
            <a href="javascript:;" id="titleCurse">课程</a>
            {% if username %}
            <a href="{{ url('user/running') }}" class="bg_green bg_radius_3">{{ username |e }}</a>
            {% else %}
            <a href="javascript:;" class="bg_green bg_radius_3" id="login">登录</a>
            {% endif %}
        </div>
    </div>
</header>