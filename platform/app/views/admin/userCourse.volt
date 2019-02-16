{% include "layouts/adminheader.volt" %}
<div class="container">
    <div class="page-header">
        <span><h1>{{ user.email }}</h1>{% if user.active == 1 %}<a class="btn btn-default btn-xs" href="#" role="button"
                                          onclick="banLogin({{ user.id }})">禁止登陆</a>{% else %}<a class="btn btn-default btn-xs"
                                                                                       href="#" role="button"
                                                                                       onclick="allowLogin({{ user.id }})">允许登陆</a>{% endif %}</span>
    </div>

    <table class="table table-hover table-striped">
        <thead>
        <tr>
            <th>id</th>
            <th><?php echo $t->_("common_name"); ?></th>
            <th><?php echo $t->_("common_description"); ?></th>
            <th><?php echo $t->_("common_state"); ?></th>
            <th><?php echo $t->_("common_operation"); ?></th>
        </tr>
        </thead>
        <tbody>
        {% for course in courses %}
        <tr>
            <td>{{ course.id|e }}</td>
            <td>{{ course.name|e }}</td>
            <td>{{ course.description|e }}</td>
            <td> {% if course.id in courseacsses_ids %}<?php echo $t->_("common_allow"); ?>{% else %}<?php echo $t->
                _("common_ban"); ?>{% endif %}
            </td>
            <td>
                {% if course.id in courseacsses_ids %}
                <a href="../unauthorize/{{ user.id|e }}/{{ course.id|e }}"><?php echo $t->_("common_ban"); ?></a>
                {% else %}
                <a href="../authorize/{{ user.id|e }}/{{ course.id|e }}"><?php echo $t->_("common_authorize"); ?></a>
                {% endif %}
            </td>
        </tr>
        {% elsefor %}
        <tr>
            <td colspan="5" style='text-align: center;'><?php echo $t->_("common_no_courses"); ?></td>
        </tr>
        {% endfor %}
        </tbody>
    </table>
</div>
<script>
    function banLogin(user_id) {
        var result = confirm("是否禁止");
        if (result) {
            $.get('{{ url("admin/banUserLogin") }}/' + user_id, function (data) {
                if (data.state == 1) {
                    alert("禁止成功");
                    location.reload();
                }
            }, "json");
        }
    }
    function allowLogin(user_id) {
        var result = confirm("是否允许");
        if (result) {
            $.get('{{ url("admin/allowUserLogin") }}/' + user_id, function (data) {
                if (data.state == 1) {
                    alert("允许成功");
                    location.reload();
                }
            }, "json");
        }
    }
</script>
{% include "layouts/oldfooter.volt" %}
