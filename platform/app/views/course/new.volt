{{ stylesheet_link("assets/bower/wangEditor/dist/css/wangEditor.min.css") }}
{% include "layouts/adminheader.volt" %}
<div class="container">
    <div class="page-header">
        <span><h1><?php echo $t->_("common_add_course"); ?></h1></span>
    </div>

    <form action="create" method="post">
        <div class="form-group">
            <label for="inputName"><?php echo $t->_("common_name"); ?></label>
            <input type="text" name="name" class="form-control" id="inputName"
                   placeholder="<?php echo $t->_('common_name'); ?>">
        </div>
        <div class="form-group">
            <label for="inputDescription"><?php echo $t->_("common_description"); ?></label>
            <input type="text" name="description" class="form-control" id="inputDescription"
                   placeholder="<?php echo $t->_('common_description'); ?>">
        </div>
        <div class="form-group">
            <label for="inputImage"><?php echo $t->_("common_image"); ?></label>
            <select id="inputImage" name="image" class="form-control">
                {% for image in images %}
                <option value="{{ image|e }}">{{ image|e }}</option>
                {% elsefor %}
                <option value="<?php echo $t->_('course_new_select_value_no_image'); ?>"><?php echo $t->
                    _("course_new_select_value_no_image"); ?>
                </option>
                {% endfor %}
            </select>
        </div>
        <div class="form-group">
            <label for="inputClassify"><?php echo $t->_("common_classify"); ?></label>
            <a class="btn btn-default btn-xs" href="#" role="button" onclick="addCate()">新增分类</a>
            <select id="inputClassify" name="category" class="form-control">
                {% for category in categorys %}
                <option value="{{ category.id|e }}">{{ category.cate_name|e }}</option>
                {% elsefor %}
                <option value="0"><?php echo $t->
                    _("course_new_select_value_no_category"); ?>
                </option>
                {% endfor %}
            </select>
            <!--<input type="text" name="classify" class="form-control" id="inputClassify"-->
            <!--placeholder="<?php echo $t->_('common_classify'); ?>">-->
        </div>
        <div class="form-group">
            <label for="inputReport"><?php echo $t->_("common_course_report"); ?></label>
            <textarea id="inputReport" name="report" class="form-control" rows="5"></textarea>
        </div>
        <div class="form-group">
            <label for="inputAnalysis"><?php echo $t->_("common_course_analysis"); ?></label>
            <textarea id="inputAnalysis" name="analysis" class="form-control" rows="3"></textarea>
        </div>
        <div class="form-group">
            <label for="inputAfterclass"><?php echo $t->_("common_course_afterclass"); ?></label>
            <textarea id="inputAfterclass" name="afterclass" class="form-control" rows="3"></textarea>
        </div>

        <div class="form-group">
            <label for="inputURL"><?php echo $t->_("common_url"); ?></label>
            <input type="text" name="url" class="form-control" id="inputUrl"
                   placeholder="<?php echo $t->_('common_url'); ?>">
        </div>

        <div class="checkbox">
            <label>
                <input type="checkbox" name="public" checked> <?php echo $t->_("common_public"); ?>
            </label>
        </div>
        <div class="checkbox">
            <label>
                <input type="checkbox" name="is_web" checked> <?php echo $t->_("course_new_input_value_is_web"); ?>
            </label>
        </div>
        <button type="submit" class="btn btn-default"><?php echo $t->_("common_submit"); ?></button>
    </form>
    <script>
        function addCate() {
            var name = prompt("请输入分类名称:", "");
            if (name != null) {
                $.get('{{ url("admin/addCategory") }}/' + name, function (data) {
                    if (data.state == 1) {
                        alert("添加成功");
                        $("#inputClassify").append("<option value='" + data.result + "'>" + name + "</option>");
                    }
                }, "json");
            }
        }
    </script>
</div>
{% include "layouts/oldfooter.volt" %}
{{ javascript_include("assets/bower/wangEditor/dist/js/wangEditor.min.js") }}
<script type="text/javascript">
    var editor = new wangEditor('inputReport');
    editor.create();
    var editor = new wangEditor('inputAnalysis');
    editor.create();
    var editor = new wangEditor('inputAfterclass');
    editor.create();
</script>