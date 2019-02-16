{% include "layouts/adminheader.volt" %}
<div class="container">
    <div class="page-header">
        <span><?php echo $t->
            _("common_my_running"); ?></span>
    </div>

    <table class="table table-hover table-striped">
        <thead>
        <tr>
            <th>id</th>
            <th><?php echo $t->_("common_name"); ?></th>
            <th><?php echo $t->_("common_my_running"); ?></th>
            <th><?php echo $t->_("common_run_time"); ?></th>
            <th><?php echo $t->_("common_last_time"); ?></th>
            <th><?php echo $t->_("common_user_last_ip"); ?></th>
            <th><?php echo $t->_("common_operation"); ?></th>
        </tr>
        </thead>
        <tbody>
        {% for container in containers %}
        <tr>
            <td>{{ container.id|e }}</td>
            <td>{{ container.users.name|e }}</td>
            <td>{{ container.courses.name|e }}</td>
            <td>{{ container.create_at|e }}</td>
            <td><?php echo round((time()-strtotime($container->create_at))/60/60); ?>小时<?php echo (round((time()-strtotime($container->create_at))/60)) % 60; ?>分钟</td>
            <td>{{ container.users.login_last_ip|e }}</td>
            <td><a href="{{ url('admin/stopContainer') }}/{{ container.container_id|e }}"><?php echo $t->_("common_delete"); ?></a></td>
        </tr>
        {% elsefor %}
        <tr>
            <td colspan="7" style='text-align: center;'><?php echo $t->_("common_no_my_running"); ?></td>
        </tr>
        {% endfor %}
        </tbody>
    </table>
</div>
{% include "layouts/oldfooter.volt" %}