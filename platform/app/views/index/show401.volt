{{ stylesheet_link("assets/bower/bootstrap/dist/css/bootstrap.min.css") }}
</head>
<body>
    <div class="container">
    <div class="page-header">
        <h1><?php echo $t->_("index_show401_h1_unauthorized"); ?></h1>
    </div>
    <h4><?php echo $t->_("index_show401_h4_please"); ?><a href="{{ url('index') }}"><?php echo $t->_("common_login"); ?></a>.</h4>
    <p>This page is located at <code>views/index/show401.volt</code></p>
    </div>
{% include "layouts/oldfooter.volt" %}