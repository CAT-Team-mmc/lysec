{{ stylesheet_link("css/info.css") }}
{% include "layouts/common_header.volt" %}
<div class="header detail-header">
    {% include "layouts/common_navbar.volt" %}
</div>
<div class="info-body">
    <div class="info-title"><span>您好，</span><span class="info-username">{{ username |e }}</span><span>，尽情享受美好时光吧！</span></div>
    <form action="{{ url('user/updateProfile') }}" method="post">
    <div>
        <table class="info-table">
            <tr>
                <td class="info-table-title">旧密码：</td>
                <td><input placeholder="<?php echo $t->_('user_profile_old_password'); ?>" name="oldpassword" type="password"
                            class="validate">
                </td>
            </tr>
            <tr>
                <td class="info-table-title">新密码：</td>
                <td><input placeholder="<?php echo $t->_('user_profile_new_password'); ?>" name="password" type="password" class="validate">
                </td>
            </tr>
            <tr>
                <td class="info-table-title">确认密码：</td>
                <td><input placeholder="<?php echo $t->_('user_profile_confirm_new_password'); ?>" name="confirmpassword" type="password"
                           class="validate"></td>
            </tr>
        </table>
    </div>
    <div class="info-button-wrap">
        <button type="submit" class="info-button">保存</button>
    </div>
    </form>
</div>
{{ javascript_include("assets/bower/jquery/dist/jquery.min.js") }}
{{ javascript_include("js/common.js") }}
{% include "layouts/footer.volt" %}
{% include "layouts/common_login.volt" %}