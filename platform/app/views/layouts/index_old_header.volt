{{ stylesheet_link("assets/bower/materialize/dist/css/materialize.min.css") }}
{{ stylesheet_link("assets/bower/font-awesome/css/font-awesome.min.css") }}
{{ stylesheet_link("css/index.css") }}
</head>
<body>
<nav class="lighten-5" role="navigation">
    <div class="nav-wrapper">
        <a href="/" class="brand-logo"><span class="grey-text text-darken-4"><?php echo $t->_("common_web_site_logo"); ?></span></a>

        <ul class="right hide-on-med-and-down">
            <li>
                <a href="{{ url('index/courses') }}" target="_blank"><span
                        class="grey-text text-darken-4"><?php echo $t->_("common_course"); ?></span></a>
            </li>
            <li>
                <a href="" target="_blank"><span class="grey-text text-darken-4"><?php echo $t->_("common_tutorials"); ?></span></a>
            </li>
            <li>
                <a href=""><span class="grey-text text-darken-4"><?php echo $t->_("common_blog"); ?></span></a>
            </li>
            <li>
                <a href="{{ url('index/qa') }}"><span class="grey-text text-darken-4"><?php echo $t->_("common_faq"); ?></span></a>
            </li>
            <li>
                {% if username %}
                <a class="dropdown-button" href="#!" data-activates="user"><span class="grey-text text-darken-4">{{ username |e }}</span><i
                        class="fa fa-caret-down" aria-hidden="true"></i></a>
                {% else %}
                <a class="waves-effect waves-light btn" href="{{ url('login/index') }}"><?php echo $t->
                    _("common_login"); ?></a>
                {% endif %}
            </li>
            <li>

            </li>
        </ul>
        <ul id="user" class="dropdown-content">
            <li><a href="{{ url('user/running') }}"><?php echo $t->_("common_my_running"); ?></a></li>
            <li><a href="{{ url('user/profile') }}"><?php echo $t->_("common_profile"); ?></a></li>
            <li class="divider"></li>
            <li><a href="{{ url('login/end') }}"><?php echo $t->_("common_logout"); ?></a></li>
        </ul>
    </div>
</nav>