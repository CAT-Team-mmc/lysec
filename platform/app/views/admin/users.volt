{% include "layouts/adminheader.volt" %}
<div class="container">
    <div class="page-header">
        {#//TODO: Add User #}
        <span><a href="{{ url('admin/userCreate') }}"><button type="button"
                                                              class="right btn btn-default"><?php echo $t->
            _("common_add_user"); ?></button></a></span>
    </div>

    <table class="table table-hover table-striped">
        <thead>
        <tr>
            <th>id</th>
            <th><?php echo $t->_("common_name"); ?></th>
            <th><?php echo $t->_("common_email"); ?></th>
            <th><?php echo $t->_("common_phone"); ?></th>
            <th><?php echo $t->_("common_user_pay_flag"); ?></th>
            <th><?php echo $t->_("common_operation"); ?></th>
        </tr>
        </thead>
        <tbody>
        {% for user in users %}
        <tr>
            <td>{{ user.id|e }}</td>
            <td>{{ user.username|e }}</td>
            <td>{{ user.email|e }}</td>
            <td>{{ user.phone|e }}</td>
            <td>{% if user.pay_flag == 0%}未付费会员{% else %}{{ user.pay_flag|e }}{% endif %}</td>
            <td><a href="#" onclick="pay({{ user.id }})">付费</a> <a href="userCourse/{{ user.id|e }}"><?php echo $t->_("common_manage"); ?></a>&nbsp;<a
                    href="resetPassword/{{ user.id|e }}" onclick="resetcfm()"><?php echo $t->_("common_reset_password"); ?></a></td>
        </tr>
        {% elsefor %}
        <tr>
            <td colspan="4" style='text-align: center;'><?php echo $t->_("common_no_users"); ?></td>
        </tr>
        {% endfor %}
        </tbody>
    </table>
    <script language="javascript">
        function resetcfm() {
            if (!confirm("确认要重置密码？")) {
                window.event.returnValue = false;
            }
        }
        function pay(user_id) {
            var pay_flag = prompt("请输入修改的付费年限:", "");
            if (pay_flag != null) {
                $.get('{{ url("admin/userPay") }}/' + pay_flag + '/' + user_id, function (data) {
                    if (data.state == 1) {
                        alert("修改成功");
                        location.reload();
                    }
                }, "json");
            }
        }
    </script>
    <script>

    </script>
</div>
{% include "layouts/oldfooter.volt" %}