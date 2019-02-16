{{ stylesheet_link("assets/bower/wangEditor/dist/css/wangEditor.min.css") }}
{% include "layouts/adminheader.volt" %}
<div class="container">
    <div class="page-header">
        <span><h1><?php echo $t->_("common_edit_qa"); ?></h1></span>
    </div>

    <form action="{{ url('admin/editQA') }}/{{ qa.id|e }}" method="post">
        <div class="form-group">
            <label for="inputQuestion"><?php echo $t->_("common_question"); ?></label>
            <input type="text" name="question" class="form-control" id="inputQuestion" placeholder="<?php echo $t->_('common_question'); ?>" value="{{ qa.meta_key }}">
        </div>
        <div class="form-group">
            <label for="inputAnswer"><?php echo $t->_("common_answer"); ?></label>
            <textarea id="inputAnswer" name="answer" class="form-control"
                      rows="3">{{ qa.meta_value|e }}</textarea>
        </div>
        <button type="submit" class="btn btn-default"><?php echo $t->_("common_submit"); ?></button>
    </form>
</div>
{% include "layouts/oldfooter.volt" %}
{{ javascript_include("assets/bower/wangEditor/dist/js/wangEditor.min.js") }}
<script type="text/javascript">
    var editor = new wangEditor('inputAnswer');
    editor.create();
</script>