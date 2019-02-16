<footer class="page-footer indigo">
    <div class="container">
        <div class="row">
            <div class="col l6 s12">
                <h5 class="white-text"><?php echo $t->_("common_footer_about_us"); ?></h5>
                <p class="grey-text text-lighten-4"><?php echo $t->_("common_footer_about_us_text"); ?></p>
            </div>
            <div class="col l3 s12">
                <h5 class="white-text"><?php echo $t->_("common_footer_company"); ?></h5>
                <ul>
                    <li><a class="white-text" href="#!">Link 1</a></li>
                    <li><a class="white-text" href="#!">Link 2</a></li>
                    <li><a class="white-text" href="#!">Link 3</a></li>
                    <li><a class="white-text" href="#!">Link 4</a></li>
                </ul>
            </div>
            <div class="col l3 s12">
                <h5 class="white-text"><?php echo $t->_("common_footer_connect"); ?></h5>
                <ul>
                    <li><a class="white-text" href="#!">Link 1</a></li>
                    <li><a class="white-text" href="#!">Link 2</a></li>
                    <li><a class="white-text" href="#!">Link 3</a></li>
                    <li><a class="white-text" href="#!">Link 4</a></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="footer-copyright">
        <div class="container">
            <?php echo $t->_("common_footer_copyright"); ?><a class="orange-text text-lighten-3">Lysec</a>
        </div>
    </div>
</footer>
{{ javascript_include("assets/bower/jquery/dist/jquery.min.js") }}
{{ javascript_include("assets/bower/materialize/dist/js/materialize.min.js") }}