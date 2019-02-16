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
            <th><?php echo $t->_("common_classify"); ?></th>
            <th><?php echo $t->_("common_description"); ?></th>
            <th><?php echo $t->_("common_state"); ?></th>
            <th><?php echo $t->_("common_operation"); ?></th>
        </tr>
        </thead>
        <tbody>
        {% for course in courses %}
        <tr>
            <td>{{ loop.index|e }}</td>
            <td>{{ course.name|e }}</td>
            <td>{{ course.coursecategory.cate_name|e }}</td>
            <td>{{ course.description|e }}</td>
            <td>{% if course.state == 1 %}<?php echo $t->_("common_public"); ?>{% else %}<?php echo $t->_("common_private"); ?>{% endif %}</td>
            <td><a href="../course/edit/{{ course.id|e }}"><?php echo $t->_("common_edit"); ?></a>&nbsp;&nbsp;<a href="../course/delete/{{ course.id|e }}"><?php echo $t->_("common_delete"); ?></a></td>
        </tr>
        {% elsefor %}
        <tr>
             <td colspan="6" style='text-align: center;'><?php echo $t->_("common_public"); ?></td>
        </tr>
        {% endfor %}
        </tbody>
    </table>
    </div>
{% include "layouts/oldfooter.volt" %}