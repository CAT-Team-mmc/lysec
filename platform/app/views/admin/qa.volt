{% include "layouts/adminheader.volt" %}
<div class="container">
    <div class="page-header">
        <span><h1>Q&A</h1></span>
        <span><a href="{{ url('admin/addQA') }}"><button type="button"
                                                              class="right btn btn-default"><?php echo $t->
            _("common_add_qa"); ?></button></a></span>
    </div>

    <table class="table table-hover table-striped">
        <thead>
        <tr>
            <th>id</th>
            <th><?php echo $t->_("common_name"); ?></th>
            <th><?php echo $t->_("common_description"); ?></th>
            <th><?php echo $t->_("common_operation"); ?></th>
        </tr>
        </thead>
        <tbody>
        {% for qa in qas %}
        <tr>
            <td>{{ qa.id|e }}</td>
            <td>{{ qa.meta_key|e }}</td>
            <td>{{ qa.meta_value|e }}</td>
            <td><a href="{{url('admin/editQA')}}/{{ qa.id|e }}"><?php echo $t->_("common_edit"); ?></a>  <a href="{{url('admin/removeQA')}}/{{ qa.id|e }}"><?php echo $t->_("common_delete"); ?></a>
            </td>
        </tr>
        {% elsefor %}
        <tr>
            <td colspan="4" style='text-align: center;'><?php echo $t->_("common_no_courses"); ?></td>
        </tr>
        {% endfor %}
        </tbody>
    </table>
</div>
{% include "layouts/oldfooter.volt" %}