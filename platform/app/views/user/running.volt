{% include "layouts/common_header.volt" %}
<div class="header detail-header">
    {% include "layouts/common_navbar.volt" %}
</div>
{% for container in containers %}
<div class="detial-body" style="padding-bottom:20px;">
    <div class="part1 clearfix" style="background:none; border-sh">
        <img src="{{container.courses.url|e }}"/>
        <ul>
            <li>{% if container.courses.is_web == 1 %}
                <a href="http://{{ container.domain|e }}{{ site|e }}" class="collection-item">{{
                    container.courses.name|e }}</a>
                {% else %}
                <a href="{{ url('user/attach') }}/{{ container.container_id|e }}" class="collection-item">{{
                    container.courses.name|e }}</a>
                {% endif %}
            </li>
            <li>{{ container.courses.description|e }}</li>
            <li class="btn-box"><a href="{{ url('user/stop') }}/{{ container.id|e }}/{{ container.container_id|e }}"
                                   class="fl"><?php echo $t->_("common_stop"); ?></a>{% if container.courses.is_web != 1 %}<a
                    href="{{ url('user/attach') }}/{{ container.container_id|e }}" class="fr"><?php echo $t->
                _("common_console"); ?></a>{% endif %}</li>
        </ul>
    </div>
</div>
{% elsefor %}
<div class="noservice-body">
    <div class="no-service">
        <p>hi,没有正在运行的服务哦！<br/><span>不如立刻去创建一个</span><br/><a href="{{ url('index/courses') }}">立即创建</a></p>
    </div>
</div>
{% endfor %}
{{ javascript_include("assets/bower/jquery/dist/jquery.min.js") }}
{{ javascript_include("js/common.js") }}
{% include "layouts/footer.volt" %}
{% include "layouts/common_login.volt" %}