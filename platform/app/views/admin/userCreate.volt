{% include "layouts/adminheader.volt" %}
<div class="container">
    <div class="page-header">
        <span><h1><?php echo $t->_("common_add_user"); ?></h1></span>
    </div>

    <form action="{{ url('admin/userNew') }}" method="post">
        <div class="form-group">
            <label for="inputName"><?php echo $t->_("common_username"); ?></label>
            <input type="text" name="name" class="form-control" id="inputName" placeholder="<?php echo $t->_('common_name'); ?>">
        </div>
        <div class="form-group">
            <label for="inputPassword"><?php echo $t->_("common_password"); ?></label>
            <input type="password" name="password" class="form-control" id="inputPassword" placeholder="<?php echo $t->_('common_password'); ?>">
        </div>
        <div class="form-group">
            <label for="inputEmail"><?php echo $t->_("common_email"); ?></label>
            <input type="text" name="email" class="form-control" id="inputEmail" placeholder="<?php echo $t->_('common_email'); ?>">
        </div>
        <div class="form-group">
            <label for="inputPhone"><?php echo $t->_("common_phone"); ?></label>
            <input type="text" name="phone" class="form-control" id="inputPhone" placeholder="<?php echo $t->_('common_phone'); ?>">
        </div>
        <div class="form-group">
            <label for="inputPayFlag"><?php echo $t->_("common_user_pay_flag"); ?></label>
            <select id="inputPayFlag" name="pay_flag" class="form-control">
                <option value="0" selected>未付费</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
                <option value="6">6</option>
                <option value="7">7</option>
                <option value="8">8</option>
                <option value="9">9</option>
                <option value="10">10</option>
            </select>
            </div>

        <div class="form-group">
            <label><?php echo $t->_("common_role"); ?></label>
            <div class="radio">
                <label>
                    <input type="radio" name="role" id="inputRole1" value="user" checked>
                    <?php echo $t->_("common_role_user"); ?>
                </label>
            </div>
            <div class="radio">
                <label>
                    <input type="radio" name="role" id="inputRole2" value="admin">
                    <?php echo $t->_("common_role_admin"); ?>
                </label>
            </div>
        </div>
        <button type="submit" class="btn btn-default"><?php echo $t->_("common_submit"); ?></button>
    </form>
    </div>
{% include "layouts/oldfooter.volt" %}