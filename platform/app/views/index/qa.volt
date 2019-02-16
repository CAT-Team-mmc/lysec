<style type="text/css">
    div.answer {
        color: #6c6c6c;
        display: none;
    }

    .qa-body .question {
        cursor: pointer;
    }
</style>
{% include "layouts/qa_header.volt" %}
<div class="qa-body">
    {% for qa in qas %}
    <div class="item">
        <h2 class="question">{{ qa.meta_key|e }}</h2>
        <div class="answer">{{ qa.meta_value }}</div>
    </div>
    {% elsefor %}
    {% endfor %}
</div>
{{ javascript_include("assets/bower/jquery/dist/jquery.min.js") }}
{{ javascript_include("js/common.js") }}
{% include "layouts/footer.volt" %}
<script>
    $(".qa-body .question").bind("click", function(){
        var obj = $(this).parent("div.item").find("div.answer");
        if (obj.is(':hidden')) {
            $(".qa-body div.item").find("div.answer:visible").hide();
            obj.show();
        } else {
            obj.hide();
        }
    })
</script>
{% include "layouts/common_login.volt" %}