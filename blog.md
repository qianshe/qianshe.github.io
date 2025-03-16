---
layout: home
title: 博客文章
---

## 最新文章

{% for post in site.posts %}
### [{{ post.title }}]({{ post.url | relative_url }})

{{ post.date | date: "%Y-%m-%d" }} | {% if post.categories %}分类: {% for category in post.categories %}{{ category }}{% unless forloop.last %}, {% endunless %}{% endfor %}{% endif %}

{% if post.excerpt %}
{{ post.excerpt }}
{% endif %}

---
{% endfor %}
