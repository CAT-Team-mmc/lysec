{% include "layouts/adminheader.volt" %}
<div class="container">
    <div class="page-header">
        <div class="row">
            <div class="col-lg-6">
                <form method="post" action="{{ url('image/create') }}">
                    <div class="input-group">
                        <input name="name" type="text" class="form-control" placeholder="<?php echo $t->_('common_image'); ?>">
                        <span class="input-group-btn">
                            <button class="btn btn-info" type="submit"><?php echo $t->_("common_pull"); ?></button>
                        </span>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <table class="table table-hover table-striped">
        <thead>
        <tr>
            <th>id</th>
            <th><?php echo $t->_("common_name"); ?></th>
            <th><?php echo $t->_("common_size"); ?></th>
            <th><?php echo $t->_("common_create_at"); ?></th>
            <th><?php echo $t->_("common_operation"); ?></th>
        </tr>
        </thead>
        <tbody>
        {% for image in images %}
        <tr>
            <td>{{ loop.index }}</td>
            <td>{% for name in image['tag'] %}
                    {{ name|e }}
                {% endfor %}
            </td>
            <td>{{ image['size']|e }} MB</td>
            <td>{{ date('Y-m-d H:i:s', image['create']) }}</td>
            <td><a href="{{ url('image/delete') }}/{{ image['id'] | e}}"><?php echo $t->_("common_remove"); ?></a></td>
        </tr>
        {% elsefor %}
        <tr>
             <td colspan="5" style='text-align: center;'><?php echo $t->_("common_no_images"); ?></td>
        </tr>
        {% endfor %}
        </tbody>
    </table>
    </div>
{% include "layouts/oldfooter.volt" %}