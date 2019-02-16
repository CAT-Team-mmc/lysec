{% include "layouts/adminheader.volt" %}
<div class="container">
    <div class="page-header">
        <span><h1><?php echo $t->_("common_edit_category"); ?></h1></span>
    </div>

    <form action="{{ url('admin/editCategoryHandle')}}" method="post">
        <div class="form-group">
            <label for="inputName"><?php echo $t->_("common_name"); ?></label>
            <input type="text" name="name" class="form-control" id="inputName" value="{{ category.cate_name|e  }}"
                   placeholder="<?php echo $t->_('common_name'); ?>">
        </div>
        <div class="form-group">
            <label for="inputDescription"><?php echo $t->_("common_sort_order"); ?></label>
            <input type="text" name="sort_order" class="form-control" id="inputDescription"
                   value="{{ category.sort_order|e  }}"
                   placeholder="<?php echo $t->_('common_sort_order'); ?>">
        </div>
        <button type="submit" class="btn btn-default"><?php echo $t->_("common_submit"); ?></button>
        <input name="category_id" value="{{ category.id }}" type="hidden">
    </form>
</div>
{% include "layouts/oldfooter.volt" %}