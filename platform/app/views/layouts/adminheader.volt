{{ stylesheet_link("assets/bower/bootstrap/dist/css/bootstrap.min.css") }}
</head>
<body>
<nav class="navbar navbar-default">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="{{ url('admin/index') }}"><?php echo $t->_("common_web_site_logo"); ?></a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a href="{{ url('admin/index') }}"><?php echo $t->_("common_course"); ?></a></li>
                <li><a href="{{ url('admin/users') }}"><?php echo $t->_("common_users"); ?></a></li>
                <li><a href="{{ url('image/index') }}"><?php echo $t->_("common_image"); ?></a></li>
                <li><a href="{{ url('admin/qa') }}">QA</a></li>
                <li><a href="{{ url('admin/monitor') }}"><?php echo $t->_("common_monitor"); ?></a></li>
                <li><a href="{{ url('admin/categories') }}"><?php echo $t->_("common_classify"); ?></a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                       aria-expanded="false">{{ username }}<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="{{ url('index/courses') }}"><?php echo $t->_("common_course"); ?></a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="{{ url('login/end') }}"><?php echo $t->_("common_logout"); ?></a></li>
                    </ul>
                </li>
            </ul>
        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>