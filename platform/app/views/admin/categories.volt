{% include "layouts/adminheader.volt" %}
<div class="container">
    <div class="page-header">
        <span><a href="{{ url('course/new') }}"><button type="button" class="right btn btn-default"><?php echo $t->_("common_add_course"); ?></button></a></span>
    </div>

    <table class="table table-hover table-striped">
        <thead>
        <tr>
            <th>id</th>
            <th><?php echo $t->_("common_name"); ?></th>
            <th><?php echo $t->_("common_sort_order"); ?></th>
            <th><?php echo $t->_("common_operation"); ?></th>
        </tr>
        </thead>
        <tbody>
        {% for category in categories %}
        <tr>
            <td>{{ loop.index|e }}</td>
            <td>{{ category.cate_name|e }}</td>
            <td>{{ category.sort_order|e }}</td>
            <td><a href="{{ url('admin/editCategory') }}/{{ category.id|e }}"><?php echo $t->_("common_edit"); ?></a>&nbsp;&nbsp;<a href="{{url('admin/deleteCategory')}}/{{ category.id|e }}"><?php echo $t->_("common_delete"); ?></a></td>
        </tr>
        {% elsefor %}
        <tr>
            <td colspan="5" style='text-align: center;'><?php echo $t->_("common_public"); ?></td>
        </tr>
        {% endfor %}
        </tbody>
    </table>
</div>
{% include "layouts/oldfooter.volt" %}